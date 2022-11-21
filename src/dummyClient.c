/* Simple udp client Stolen from http://www.binarytides.com/programming-udp-sockets-c-linux/ */ 

#include "krypto.h"


int main(int argc, char *argv[]) {
    
    char a[100];
    char *destIp = a;
    if (argc < 2) {
        strcpy(a,getLocalIp(1));
    }
    else {
        destIp= argv[1];
    }
    
    struct sockaddr_in si_other;
    int s, j, slen=sizeof(si_other);
    uint8_t buf[BUFLEN]={0};
    uint8_t sig[SIGLEN] = {0};
    uint8_t msg[MSGLEN];
    uint8_t hmac[HMACLEN];
    uint8_t publicKey[PUBKEYLEN];
    unsigned char hmacKey[64];
    char expectedIP[16] = {0};
    
    int port = 0;
    int *portPtr = &port;

    int verbose = 1;

    if (!readConfig(verbose, publicKey, hmacKey, expectedIP,portPtr)) {
        return 0;
    }
 
    if ( (s=socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP)) == -1) {
        die("socket");
    }

 
    memset((char *) &si_other, 0, sizeof(si_other));
    si_other.sin_family = AF_INET;
    si_other.sin_port = htons(port);
     
    //if (inet_aton(SERVER , &si_other.sin_addr) == 0) {
    if (inet_aton(destIp , &si_other.sin_addr) == 0) {
        fprintf(stderr, "inet_aton() failed\n");
        exit(1);
    }

   srand(time(NULL));  

    for (j = 0; j<MSGLEN; j++) {
        msg[j] = rand();
        buf[j]= msg[j];
    }

    //hmac part:
    //unsigned char key[] = "1";
    createHmac(msg, hmac, hmacKey);

    for (j = 0; j < HMACLEN; j++) {
        buf[j+MSGLEN] = hmac[j];
        hmac[j] = hmac[j];
    }
   
    //ecc part:
    const uint8_t privatekey[PRIVKEYLEN] = {0,109,203,127,255,237,255,187,234,245,206,251,47,239,79,231,253,240,119,87,89,0,0,0,0,0,0,0,0,0,0,0};
    const uint8_t publickey[PUBKEYLEN] =   {121,111,188,74,140,239,209,189,153,65,212,107,118,19,119,136,147,218,157,255,171,223,94,123,250,221,159,
    128,205,198,255,204,181,94,144,183,249,128,185,28,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};

    const struct uECC_Curve_t * curve = uECC_secp160r1();
    if (!uECC_sign(privatekey, hmac, sizeof(hmac), sig, curve)) {
        printf("Signing failed\n");
    }
    if (!uECC_verify(publickey, hmac, sizeof(hmac), sig, curve)) {
        printf("Bad Sig! (uECC_verify() failed)  \n");
    }
    
    for (j=0; j < SIGLEN; j++) {
        buf[j+HMACLEN+MSGLEN] = sig[j];
    }

    //send the message
    printf("\nTrying to send msg: ");
    printDigest( (uint8_t *) createDigest(msg, MSGLEN), MSGLEN);
    printf("To: %s.\n", destIp);
    printf("With:\n");
    printf("HMAC: ");
    //printDigest(hmac, HMACLEN);
    printDigest( (uint8_t *) createDigest(hmac, HMACLEN), HMACLEN);
    printf("SIG: ");
    //printDigest(sig, SIGLEN);
    printDigest( (uint8_t *) createDigest(sig, SIGLEN), SIGLEN);

    if (sendto(s, buf, BUFLEN , 0 , (struct sockaddr *) &si_other, slen)==-1) {
        die("sendto()");
    }
    else {
        printf("Ok\n");
    }
        
    return 0;
}

