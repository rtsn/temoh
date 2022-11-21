# 'make' to build temoh
# 'make cli' to make dummy client
CC = gcc
CFLAGS = -Wall -g -D_GNU_SOURCE -lsqlite3 -lssl -lcrypto -lconfig 
OBJECTS = src/krypto.c src/misc.c src/uECC/uECC.c
TEMOHMAIN = src/main.c
CLIMAIN = src/dummyClient.c

temoh  : $(OBJECTS)
		$(CC) $(CFLAGS) $(TEMOHMAIN)  $(OBJECTS) -o temoh
cli    : $(OBJECTS)
		$(CC) $(CFLAGS) $(CLIMAIN)  $(OBJECTS) -o cli
