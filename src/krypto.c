#include"krypto.h"

/*
#include <openssl/engine.h>
#include <openssl/hmac.h>
#include <openssl/evp.h>


void createHmac(uint8_t msg[MSGLEN], uint8_t hmac[HMACLEN], unsigned char *key) {
    unsigned char* result;
    unsigned int result_len = HMACLEN; 
    int i;

    HMAC_CTX ctx;

    result = (unsigned char*) malloc(sizeof(char) * result_len);
 
    ENGINE_load_builtin_engines();
    ENGINE_register_all_complete();

    HMAC_CTX_init(&ctx);
    HMAC_Init_ex(&ctx, key, 1, EVP_sha256(), NULL);
            
    uint8_t *msgpointer = msg;
    unsigned char *char_pointer = (unsigned char*)msgpointer;

    for (i=0; i < MSGLEN; i++) {
        HMAC_Update(&ctx, char_pointer+i, 1);
    }

    HMAC_Final(&ctx, result, &result_len);
    HMAC_CTX_cleanup(&ctx);

    for (i=0; i < HMACLEN; i++) {
        hmac[i] = result[i];
    }
}

int hmacCheck(uint8_t msg[MSGLEN], uint8_t hmac[HMACLEN], unsigned char *key) {
    int i;
    uint8_t result[HMACLEN];
    
    printf("- HMAC CHECK...  ");

    createHmac(msg, result, key);

    if (memcmp(result, hmac, HMACLEN) != 0) {
        printf(ANSI_COLOR_RED "Bad HMAC.\n"  ANSI_COLOR_RESET);

        printf("expected: ");
        for (i = 0; i <HMACLEN; i++) {
            printf("%d ", result[i]);
        }
        printf("\n");
        
        return 0;
    }
    else {
        printf(ANSI_COLOR_GREEN "OK!\n" ANSI_COLOR_RESET );
        return 1;
    }
}
*/

int ecdsaCheck(const uint8_t publickey[PUBKEYLEN], uint8_t msg[MSGLEN], uint8_t sig[SIGLEN]) {
    printf("- ECDSA CHECK... ");
    const struct uECC_Curve_t * curve = uECC_secp160r1();
    if (!uECC_verify(publickey, msg, MSGLEN, sig, curve)) {
        printf(ANSI_COLOR_RED "Bad Sig (uECC_verify() failed).  \n"  ANSI_COLOR_RESET);
        return 0;
    }
    else {
        printf(ANSI_COLOR_GREEN "OK!\n"  ANSI_COLOR_RESET);
        return 1;
    }
}


int verifyPubKey(uint8_t publicKey[PUBKEYLEN], int verbose) {
    if (uECC_valid_public_key(publicKey, uECC_secp160r1())) {
        if (verbose) {
            printf(ANSI_COLOR_GREEN "Good public key.\n"  ANSI_COLOR_RESET);
        }
        return 1;
    }
    else {
        printf(ANSI_COLOR_RED "Unvalid public key\n"  ANSI_COLOR_RESET);
        return 0;
    }   
}


