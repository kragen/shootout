CC=gcc
JAVADIR=/usr/lib/java/current
JAVAINC=/usr/lib/java/current/include
OS=linux
CFLAGS=-pipe -Wall -O3 -fomit-frame-pointer -shared -I$(JAVAINC) -I$(JAVAINC)/$(OS) -static

JAVACC=javac
JAVAH=javah

all: liback.so

liback.so: ack.c ack.h
	$(CC) $(CFLAGS) ack.c -o liback.so

ack.class: ack.java
	$(JAVACC) ack.java

ack.h: ack.class
	$(JAVAH) ack

clean:
	rm ack.h ack.class liback.so
