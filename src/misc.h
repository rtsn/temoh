#include <stdio.h>  
#include <string.h> 
#include <stdlib.h> 
#include <stdint.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <time.h>
#include <sqlite3.h>
#include <errno.h> //errno
#include <netinet/in.h> //sockaddr_in
#include <unistd.h>    //close
#include <libconfig.h>


#define BUFLEN 80 //Max length of buffer
#define MSGLEN 16
#define SIGLEN 64
#define PUBKEYLEN 64
#define PRIVKEYLEN 32
#define IPLEN 16

#define ANSI_COLOR_RED     "\x1b[31m"
#define ANSI_COLOR_GREEN   "\x1b[32m"
#define ANSI_COLOR_YELLOW  "\x1b[33m"
#define ANSI_COLOR_BLUE    "\x1b[34m"
#define ANSI_COLOR_MAGENTA "\x1b[35m"
#define ANSI_COLOR_CYAN    "\x1b[36m"
#define ANSI_COLOR_RESET   "\x1b[0m"

int callback(void *NotUsed, int argc, char **argv, char **azColName);

void die(char *s);

int addToDb(int verbose);

/* OLD:
int readConfig(int verbose, uint8_t publicKey[PUBKEYLEN],
        unsigned char hmacKey[HMACKEYLEN], char expectedIP[IPLEN], 
        int *port);
*/

int readConfig(int verbose, uint8_t publicKey[PUBKEYLEN],
    char expectedIP[IPLEN], int *port);

/* OLD:
void bufSplit(uint8_t buf[BUFLEN], uint8_t msg[MSGLEN], 
    uint8_t hmac[HMACLEN],uint8_t sig[SIGLEN],int verbose);
*/

void bufSplit(uint8_t buf[BUFLEN], uint8_t msg[MSGLEN], 
    uint8_t sig[SIGLEN],int verbose);


int ipCheck(int doIpCheck, char expectedip[IPLEN], char ip[IPLEN], int verbose);

void printTimestamp();

void printDigest(uint8_t digest[], int length);

char * getLocalIp(int verbose);

char * createDigest(uint8_t digest[], int length);

char * truncDigest(char *digest);
