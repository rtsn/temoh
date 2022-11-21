#include <types.h>
#include <uECC_vli.h>
#include <uECC.h>

/// PIR + UDP + ECC-signering
#include <SPI.h>
#include <Ethernet.h>
#include <EthernetUdp.h>




//#include <uECC_vli.h>
//#include <types.h>
//#include <uECC.h>

/////// Hmac-stuff
//#include <printf.h>
//#include "sha256.h"
///////

extern "C" {
  static int RNG(uint8_t *dest, unsigned size) {
    // Use the least-significant bits from the ADC for an unconnected pin (or connected to a source of
    // random noise). This can take a long time to generate random data if the result of analogRead(0)
    // doesn't change very frequently.
    while (size) {
      uint8_t val = 0;
      for (unsigned i = 0; i < 8; ++i) {
        int init = analogRead(0);
        int count = 0;
        while (analogRead(0) == init) {
          ++count;
        }

        if (count == 0) {
          val = (val << 1) | (init & 0x01);
        } else {
          val = (val << 1) | (count & 0x01);
        }
      }
      *dest = val;
      ++dest;
      --size;
    }
    // NOTE: it would be a good idea to hash the resulting random data using SHA-256 or similar.
    return 1;
  }
}

//
//void printHash(uint8_t* hash, int sizeofhash) {
//  int i;
//  for (i = 0; i < sizeofhash; i++) {
//    Serial.print("0123456789abcdef"[hash[i] >> 4]);
//    Serial.print("0123456789abcdef"[hash[i] & 0xf]);
//    delay(10); //verkar bli crazy utan delay
//  }
//  //Serial.println();
//}

void genMsg(uint8_t msg[16]) { // generate stupid msg
  uint8_t *msgpointer = msg;;
  for (int i = 0; i < 16; i++) {
    RNG(msgpointer+i, 1);
  }
}

//void hashMsg(uint8_t* hash, uint8_t* msg) {
//  uint8_t hmacKey[] = "1";
//  Sha256.initHmac(hmacKey, 1);
//  int j;
//  for (j = 0; j < 16; j++) {
//    Sha256.write(msg[j]);
//  }
//  memcpy(hash, Sha256.resultHmac(), 32);
//  for (j = 0; j < 32; j++) {
//      Serial.print(hash[j]);
//      Serial.print(" ");
//  }
//  Serial.println();
//   //memcpy(hash, Sha256.resultHmac(), sizeof(uint8_t) * 32);  
//}

//ecdsa
const struct uECC_Curve_t * curve = uECC_secp160r1();

//uint8_t privatekey[32] = {0};
//uint8_t publickey[64] = {0};

//NEW HARDCODED KEYS
const uint8_t privatekey[32] = {0, 109, 203, 127, 255, 237, 255, 187, 234, 245, 206, 251, 47, 239, 79, 231, 253, 240, 119, 87, 89, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
const uint8_t publickey[64] = {121, 111, 188, 74, 140, 239, 209, 189, 153, 65, 212, 107, 118, 19, 119, 136, 147, 218, 157, 255, 171, 223, 94, 123, 250, 221, 159,
                               128, 205, 198, 255, 204, 181, 94, 144, 183, 249, 128, 185, 28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                              };

uint8_t msg[16] = {0};
//uint8_t hash[32] = {0};
uint8_t sig[64] = {0};

void genStuff() { // generate msg, hmac of msg and signature of hmac of msg
  ///////////////////// MSG
  Serial.println(">>> Generating... ");
  genMsg(msg);
  delay(200);
//  printHash(msg, 16);
//  Serial.println();
//  delay(200);

//  ///////////////////// HMAC
//  Serial.println(">>> Hashing... ");
//  delay(200);
//  hashMsg(hash, msg);
//  delay(200);
//  printHash(hash, 32);
//  Serial.println();

  ///////////////////// ECCDSA
  Serial.println(">>> Signing... ");
  if (!uECC_sign(privatekey, msg, sizeof(msg), sig, curve)) {
    Serial.print(" uECC_sign() failed\n");
  }
  else {
//    printHash(sig, 64);
//    Serial.println();

    Serial.println(">>> Verifying... ");
    delay(50);
    if (!uECC_verify(publickey, msg, sizeof(msg), sig, curve)) {
      Serial.print(" uECC_verify() failed\n");
    }
    else {
      delay(20);
      Serial.println("Ok");
    }
  }
}

//void wavePrint(int n) { // print n number of '-'
//  for (int i = 0; i < n; i++) {
//    Serial.print("-");
//  }
//  Serial.println();
//}

//UDP
byte MacAddress[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };
IPAddress MyIPAddress(192, 168, 0, 111);
unsigned int LocalPort = 8888;  //needed???
IPAddress DestinationAddress(192, 168, 0, 101);
unsigned int DestinationPort = 8888;
EthernetUDP Udp; // To send & receive packets using UDP

//void trans(msg,hash, sig)
void trans() { // skicka udp. ändra så att trans(*pekare) till output && addera parametrar
//void trans(uint8_t* msg, uint8_t* hmac, uint8_t* sig ) {
  Udp.beginPacket(DestinationAddress, DestinationPort);
  
  //Udp.println("72! ");
  //byta till Udp.write(); ?? enl. http://forum.arduino.cc/index.php?topic=105431.0
  //Udp.write(msg, 16);

  Udp.write(msg, 8);
//  Udp.write(hash, 32);
  Udp.write(sig, 64);
  Udp.endPacket();
}

//Hardware
const int pirPin = 2; //digital 2
const int ledRed =  9;
const int ledGreen =  8;


//Misc
int pirVal;

void setup() {
  Ethernet.begin(MacAddress, MyIPAddress);
  Udp.begin(LocalPort);
  Serial.begin(9600);
  pinMode(pirPin, INPUT);
  pinMode(ledRed, OUTPUT);
  pinMode(ledGreen, OUTPUT);
  digitalWrite(ledRed, LOW);
  digitalWrite(ledGreen, HIGH);
  pirVal = digitalRead(pirPin);
  uECC_set_rng(&RNG);

  //  Serial.println("Creating keypair"); // Uncomment for key creation
  //  vala = millis();
  //  if (!uECC_make_key(publickey, privatekey, curve)) {
  //    Serial.print(" uECC_make_key() failed\n");
  //    //restart
  //   }
  //  else {
  //    valb = millis();
  //    Serial.print("Made key in "); Serial.println(valb - vala);
  //  }
  //
  //  printHash(publickey,64);
  //  Serial.println();
  //  for (int i = 0; i < 64; i++) {
  //    Serial.print(publickey[i]);
  //    Serial.print(",");
  //  }
  //  Serial.println();
  //  Serial.println();
  //  Serial.println();
  //  printHash(privatekey,32);
  //  Serial.println();
  //    for (int i = 0; i < 32; i++) {
  //    Serial.print(privatekey[i]);
  //    Serial.print(",");
  //  }
  Serial.println("Generating initial stuff");

  genStuff();

//  Serial.println(">>> Warming up...");
//  for (int i = 19; i > 0; i--) { // varmup
//    pirVal = digitalRead(pirPin);
//    Serial.print(".");
//    digitalWrite(ledGreen, LOW);
//    delay(150);
//    digitalWrite(ledGreen, HIGH);
//    delay(10);
//  }
  Serial.println();
  delay(500);

}

int i = 0;

void loop() {
  if (i == 0) {
    Serial.println(">>> Warming up...");
    for (i = 0; i < 20; i++) {
      pirVal = digitalRead(pirPin);
      delay(300);
    }
    i = 1;
  }

  pirVal = digitalRead(pirPin);

  if (pirVal == LOW) { //motion detected
    digitalWrite(ledRed, HIGH);
    digitalWrite(ledGreen, LOW);

    Serial.println(">>> Motion Detected");

    Serial.println(">>> Sending...");
//    trans(msg, hmac, sig); //skicka udp paket
    // styra trans(msg, hash, sig)
    trans();
    Serial.println(">>> Waiting...");

    for (int k = 0; k < 5; k++) {
      Serial.print(10 - k);
      Serial.print(" ");
      delay(1000);
    }
//    digitalWrite(ledRed, LOW);
    Serial.println(0);
    delay(100);
//    digitalWrite(ledGreen, HIGH);
    genStuff();
  }

  Serial.println(">>> Waiting for motion");
  trans();
  delay(400);
}
