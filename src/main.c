#include "krypto.h"

int main(int argc, char *argv[]) {

    int verbose = 0; // assume not verbose
    if (argc > 1 && strcmp(argv[1],"-v") == 0) { 
        verbose = 1;
    }
        
    struct sockaddr_in si_me, si_other;
    int s, recv_len;
    unsigned int slen = sizeof(si_other);
    char expectedIP[16] = {0}; 
    uint8_t buf[BUFLEN] = {0};
//    unsigned char hmacKey[64];
    uint8_t publicKey[PUBKEYLEN] = {0};

    int port = 0;
    int *portPtr = &port;

    //!!
    if (!readConfig(verbose, publicKey, expectedIP,portPtr)) {
        return 0;
    }

    if (!verifyPubKey(publicKey, verbose)) {
        return 0;
    }

    //unsigned char* hmacKeyPointer = (unsigned char*) hmacKey; // why???

    int doIpCheck = 1; // assume ipcheck
 
    if (strcmp(expectedIP, "0") == 0) { // if ip in temoh.cfg = "0"; skip ipcheck
        doIpCheck = 0;
        if (verbose) {
            printf("Accepting packets from any IP adress.\n");
        }
    }

    //create a UDP socket
    if ((s=socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP)) == -1) {
        die("socket");
    }
    
    // zero out the structure
    memset((char *) &si_me, 0, sizeof(si_me));
    
    si_me.sin_family = AF_INET;
    si_me.sin_port = htons(port);
    si_me.sin_addr.s_addr = htonl(INADDR_ANY);
    
    //bind socket to port
    if( bind(s , (struct sockaddr*)&si_me, sizeof(si_me) ) == -1) {
        die("bind");
    }

    uint8_t msg[MSGLEN]; 
//    uint8_t hmac[HMACLEN];
    uint8_t sig[SIGLEN];
    int entryid; 
    
    //keep listening for data
    while(1) {

        memset(msg, 0, sizeof(msg));
 //       memset(hmac, 0, sizeof(hmac));
        memset(sig, 0, sizeof(sig));

        if (verbose) {
            printf("\n\nWaiting for data...\n\n");
        }

        fflush(stdout);
        
        //try to receive some data, this is a blocking call
        if ((recv_len = recvfrom(s, buf, BUFLEN, 0, (struct sockaddr *) &si_other, &slen)) == -1) {
            die("recvfrom()");
        }
        
        //print details of the client/peer and the data received
        printTimestamp();
        printf("Received packet from %s:%d\n", inet_ntoa(si_other.sin_addr), ntohs(si_other.sin_port));

        if (ipCheck(doIpCheck, expectedIP,inet_ntoa(si_other.sin_addr),verbose)) {
            bufSplit(buf,msg,sig,verbose);
//            if (hmacCheck(msg,hmac,hmacKeyPointer) && ecdsaCheck(publicKey,hmac, sig)) {
            if (ecdsaCheck(publicKey, msg, sig)) {
                printf("- Add to db...   ");
                entryid = addToDb(verbose);
                if (entryid) {
                    printf(ANSI_COLOR_GREEN "OK!" ANSI_COLOR_RESET " (id:%d) \n",entryid);
                }
                else {
                    printf(ANSI_COLOR_RED "db error\n"  ANSI_COLOR_RESET);
                    printf("db error\n");   
                }
            }
        }
    }
    return 0;
}
