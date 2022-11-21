//#include <openssl/engine.h>
//#include <openssl/hmac.h>
//#include <openssl/evp.h>
#include "uECC/uECC.h"
#include "misc.h"

/*
void createHmac(uint8_t msg[MSGLEN], uint8_t hmac[HMACLEN], unsigned char *key);

int hmacCheck(uint8_t msg[MSGLEN], uint8_t hmac[HMACLEN], unsigned char *key);
*/

int ecdsaCheck(const uint8_t publickey[PUBKEYLEN], uint8_t msg[MSGLEN], uint8_t sig[SIGLEN]);

int verifyPubKey(uint8_t publicKey[PUBKEYLEN], int verbose);

