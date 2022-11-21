#include "misc.h"

void printTimestamp() {
    time_t ltime; /* calendar time */
    ltime=time(NULL); /* get current cal time */
    printf("\n\n%s",asctime( localtime(&ltime) ) );
}

// write documentation on this function in more detail
int callback(void *NotUsed, int argc, char **argv, char **azColName) {
   int i;
   for(i=0; i<argc; i++){
      printf("%s = %s\n", azColName[i], argv[i] ? argv[i] : "NULL");
   }
   printf("\n");
   return 0;
}

void die(char *s) {
    perror(s);
    exit(1);
}

/*
void bufSplit(uint8_t buf[BUFLEN], uint8_t msg[MSGLEN],
    uint8_t hmac[HMACLEN],uint8_t sig[SIGLEN],int verbose) {

    int i;
    for (i = 0; i < MSGLEN; i++) {
        msg[i] = buf[i];
    }

    for (i = 0; i < HMACLEN; i++) {
        hmac[i] = buf[MSGLEN +i];
    }
    
    for (i = 0; i < SIGLEN; i++) {
        sig[i] = buf[MSGLEN + HMACLEN + i];
    }
    if (verbose) {
        printf("- MSG:  ");
        printDigest(msg, MSGLEN);
        printf("- HMAC: ");
        printDigest(hmac, HMACLEN);
        printf("- SIG:  ");
        printDigest(sig, SIGLEN);
    }
}
*/


void bufSplit(uint8_t buf[BUFLEN], uint8_t msg[MSGLEN],
    uint8_t sig[SIGLEN], int verbose) {

    int i;

    for (i = 0; i < MSGLEN; i++) {
        msg[i] = buf[i];
    }

    
    for (i = 0; i < SIGLEN; i++) {
        sig[i] = buf[MSGLEN + i];
    }
    if (verbose) {
        printf("- MSG:  ");
        printDigest(msg, MSGLEN);
        printf("- SIG:  ");
        printDigest(sig, SIGLEN);
    }
}


int ipCheck(int doIpCheck, char expectedip[IPLEN], char ip[IPLEN], int verbose) {
    if (!doIpCheck) {
        if (verbose) {
            printf("Skipping IP check.\n");
        }
        return 1;
    }
    printf("- IP CHECK...    ");

    if (memcmp(expectedip, ip, 13) != 0) {
        printf(ANSI_COLOR_RED "Failed!\n"  ANSI_COLOR_RESET);
        return 0;
    }
    else {
        printf(ANSI_COLOR_GREEN "OK!\n"  ANSI_COLOR_RESET);
        return 1;
    }
}

int addToDb(int verbose) {
    sqlite3 *db;
    char *zErrMsg = 0;
    int  rc;
    char *sql;
    

    /* Open database */
    rc = sqlite3_open("temoh.db", &db);
    if( rc ){
        fprintf(stderr, "Can't open database: %s\n", sqlite3_errmsg(db));
        return 0;
    }
    else {
        if (verbose) {
            fprintf(stdout, " (Opened database successfully) ");
        }
    }

    /* Check if table exists */
    sql = "select count(type) from sqlite_master where type='table' and name='TEMOHTABLE';";
    sqlite3_stmt *statement;
    if ( sqlite3_prepare(db, sql, -1, &statement, 0 ) == SQLITE_OK ) {
        int res = 0;
        res = sqlite3_step(statement);
        if ( res == SQLITE_ROW ) {
            char *s = (char*)sqlite3_column_text(statement, 0);
            //printf("%s\n", s);
                
            /* If table doesn't exist - create it! */
            if (strcmp ("0", s) == 0) {
                sql = "CREATE TABLE TEMOHTABLE("  \
                "ID INTEGER PRIMARY KEY AUTOINCREMENT," \
                "sqltime TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL);";
                // skip if strmp("0") != 0
            
                /* Execute SQL statement */
                rc = sqlite3_exec(db, sql, callback, 0, &zErrMsg);
                if( rc != SQLITE_OK ){
                    fprintf(stderr, "SQL error: %s\n", zErrMsg);
                    sqlite3_free(zErrMsg);
                    return 0;
                }
                else {
                    if (verbose) {
                        fprintf(stdout, "(Table created successfully) ");
                    }
                }
            }
        }
    }

    sqlite3_finalize(statement);
    
    sql = "INSERT INTO TEMOHTABLE (ID) " \
          "VALUES (NULL)";

    // Execute SQL statement 
    rc = sqlite3_exec(db, sql, callback, 0, &zErrMsg);
    if( rc != SQLITE_OK ){
        fprintf(stderr, "SQL error: %s\n", zErrMsg);
        sqlite3_free(zErrMsg);
        sqlite3_close(db);
        return 0;
    }
    else {
        int output = sqlite3_last_insert_rowid(db);
        sqlite3_close(db);
        return output;
    }
    sqlite3_close(db);
}

/*
void printDigest(uint8_t digest[], int length) {
    // Be careful of the length of string with the choosen hash engine.
    // SHA1 produces a 20-byte hash value which rendered as 40
    // characters.// Change the length accordingly with your choosen
    // hash engine
    //
    char hex_tmp[(length*2) +1];
    char * strPtr = hex_tmp;

    for (int i = 0; i < length; i++)  {
        sprintf(&hex_tmp[i*2],"%02x", digest[i]); 
    }

    char x = hex_tmp[(length*2)-1];

    if (x == '0') {
        int zeroCounter = 1;
        while (x == '0') {
          x = hex_tmp[(length*2) -1 - zeroCounter];
          zeroCounter++;
        }
        if (zeroCounter > 5) {
            hex_tmp[(length*2) - zeroCounter +1] = '\0'; // remove zeros
            asprintf(&strPtr, "%s%s%d%s",hex_tmp, "[+", zeroCounter,"x0]");
        }
    }   
    printf("%s\n", strPtr);
}
*/

char * createDigest(uint8_t digest[], int length) {
    // Be careful of the length of string with the choosen hash engine.
    // SHA1 produces a 20-byte hash value which rendered as 40
    // characters.// Change the length accordingly with your choosen
    // hash engine
    //
    char hex_tmp[(length*2) +1];
    char * strPtr = hex_tmp;

    memset(hex_tmp, 0, sizeof(hex_tmp));

    for (int i = 0; i < length; i++)  {
        sprintf(&hex_tmp[i*2],"%02x", digest[i]); 
    }
    
//  printf("%s\n", strPtr);
    return strPtr;
}

char * truncDigest(char *digest) {
    int zeroCounter = 0;
    char truncated[512];
    strcpy(truncated, digest);

    while (truncated[strlen(truncated) -1] == '0') {
        zeroCounter++;
        truncated[strlen(truncated) -1] = '\0';
    }

    char * s = malloc(snprintf(NULL, 0, "%s%s%d%s", truncated, "[",zeroCounter, "x0]") + 1); 
    sprintf(s, "%s%s%d%s", truncated, "[",zeroCounter, "x0]") ;

    return s;  
}


void printDigest(uint8_t *digest, int length) {
    // todo: count number of zeroes truncate as above
    printf("%s\n", digest);
}



char * getLocalIp(int verbose) {

    const char* google_dns_server = "8.8.8.8";
    int dns_port = 53; 
    
    struct sockaddr_in serv;
    
    int sock = socket ( AF_INET, SOCK_DGRAM, 0); 
    
    //Socket could not be created
    if(sock < 0) {   
        perror("Socket error");
    }   
    
    memset(&serv, 0, sizeof(serv));
    serv.sin_family = AF_INET;
    serv.sin_addr.s_addr = inet_addr(google_dns_server);
    serv.sin_port = htons(dns_port);
 
    int err = connect(sock , (const struct sockaddr*) &serv , sizeof(serv));
    
    struct sockaddr_in name;
    socklen_t namelen = sizeof(name);
    err = getsockname(sock, (struct sockaddr*) &name, &namelen);
    
    char buffer[100];
    const char* p = inet_ntop(AF_INET, &name.sin_addr, buffer, 100);
   
    err++;
    if (p != NULL) {   
        if (verbose) {
            printf("Local ip is : %s \n" , buffer);
        }
        char *ptrBuf = buffer;
        return ptrBuf;
    }   
    else  {   
        //Some error
        printf ("Error number : %d . Error message : %s \n" , errno , strerror(errno));
        return NULL;
    }   
    close(sock);
}

/*
int readConfig(int verbose, uint8_t publicKey[PUBKEYLEN],
    unsigned char hmacKey[HMACKEYLEN], char expectedIP[IPLEN], 
    int *port) {

    config_t cfg, *cf;
    const char *tmpHmacKey;
    const char *tmpExpectedIP;
    const config_setting_t *metaPubKey;
    
    cf = &cfg;
    config_init(cf);

    if (!config_read_file(cf, "temoh.cfg")) {
        fprintf(stderr, "%s:%d - %s\n",
        config_error_file(cf),
        config_error_line(cf),
        config_error_text(cf));
        config_destroy(cf);
        return 0;
    }

    if (config_lookup_string(cf, "hmacKey", &tmpHmacKey)) {
        memcpy(hmacKey, tmpHmacKey,strlen(tmpHmacKey)+1);
    }
    else { 
        printf(ANSI_COLOR_RED "hmacKey is not defined\n" ANSI_COLOR_RESET);
        return 0;
    }

    if (config_lookup_string(cf, "expectedIP", &tmpExpectedIP)) {
        memcpy(expectedIP, tmpExpectedIP, strlen(tmpExpectedIP)+1);
    }
    else {
        printf(ANSI_COLOR_RED "expectedIP is not defined (or set to 0).\n" ANSI_COLOR_RESET);
        return 0;
    }


    if (!config_lookup_int(cf, "port", &(*port))) {
        printf(ANSI_COLOR_RED "Port number is not defined.\n" ANSI_COLOR_RESET);
        return 0;
    }

    metaPubKey = config_lookup(cf, "pubKey");

    if (metaPubKey) {
        for (int i = 0; i < config_setting_length(metaPubKey); i++) {
            publicKey[i] = config_setting_get_int_elem(metaPubKey, i);
        }
    }
    else {
        printf(ANSI_COLOR_RED "pubKey is not defined.\n" ANSI_COLOR_RESET);
        return 0;
    }

    config_destroy(cf);

    if (verbose) {
        printf("Imported the following data from config:\n");
        printf("HMAC Key: %s\n", hmacKey);
        printf("Expected IP adr: %s\n", expectedIP);
        printf("Pub key: %s\n", createDigest(publicKey, PUBKEYLEN)); 
        printf("Port: %d\n",*port);
    }   
    return 1;
}
*/

int readConfig(int verbose, uint8_t publicKey[PUBKEYLEN],
    char expectedIP[IPLEN], int *port) {

    config_t cfg, *cf;
//    const char *tmpHmacKey;
    const char *tmpExpectedIP;
    const config_setting_t *metaPubKey;
    
    cf = &cfg;
    config_init(cf);

    if (!config_read_file(cf, "temoh.cfg")) {
        fprintf(stderr, "%s:%d - %s\n",
        config_error_file(cf),
        config_error_line(cf),
        config_error_text(cf));
        config_destroy(cf);
        return 0;
    }


    if (config_lookup_string(cf, "expectedIP", &tmpExpectedIP)) {
        memcpy(expectedIP, tmpExpectedIP, strlen(tmpExpectedIP)+1);
    }
    else {
        printf(ANSI_COLOR_RED "expectedIP is not defined (or set to 0).\n" ANSI_COLOR_RESET);
        return 0;
    }


    if (!config_lookup_int(cf, "port", &(*port))) {
        printf(ANSI_COLOR_RED "Port number is not defined.\n" ANSI_COLOR_RESET);
        return 0;
    }

    metaPubKey = config_lookup(cf, "pubKey");

    if (metaPubKey) {
        for (int i = 0; i < config_setting_length(metaPubKey); i++) {
            publicKey[i] = config_setting_get_int_elem(metaPubKey, i);
        }
    }
    else {
        printf(ANSI_COLOR_RED "pubKey is not defined.\n" ANSI_COLOR_RESET);
        return 0;
    }

    config_destroy(cf);

    if (verbose) {
        printf("Imported the following data from config:\n");
        printf("Expected IP adr: %s\n", expectedIP);
        printf("Pub key: %s\n", createDigest(publicKey, PUBKEYLEN)); 
        printf("Port: %d\n",*port);
    }   
    return 1;
}
