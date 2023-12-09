CC=gcc
CFLAGS=-Wall -O3 -D_FORTIFY_SOURCE=1 -march=native 
LDFLAGS=-Wl,-z,noexecstack, -static

SRC = $(wildcard *.c)
BIN = $(patsubst %.c,bin/%,$(SRC))

all: bin $(BIN)

bin/%: %.c
	$(CC) $(CFLAGS) $< -o $@
	strip $@
	sudo chown root:root $@	
	sudo chmod 4755 $@

bin:
	mkdir -p bin

clean:
	rm -f bin/*
