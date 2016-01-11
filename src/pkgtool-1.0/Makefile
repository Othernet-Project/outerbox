CC      = gcc
LD      = ld
STRIP	= strip
CFLAGS  += -Wall -DLINUX
LIBS	 = -lstdc++ -lcrypto

DEL_FILE 	= rm -f

HEADERS	 = $(wildcard *.h)

TARGETS  = pkgtool mkpkg

.PHONY: install clean debug release

first: debug

debug: CFLAGS += -ggdb
debug: HOSTCFLAGS += -ggdb
release: CFLAGS += -O2
release: HOSTCFLAGS += -O2

debug release: $(TARGETS)

mkpkg: mkpkg.cpp installer.o $(HEADERS)
	@rm -f $@
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ mkpkg.cpp installer.o $(LIBS)

pkgtool: pkgtool.cpp $(HEADERS)
	@rm -f $@
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ pkgtool.cpp $(LIBS)

installer.o: installer.cpp $(HEADERS)
	@rm -f $@
	$(CC) $(CFLAGS) $(LDFLAGS) -o installer.bin installer.cpp -static $(LIBS)
	$(STRIP) installer.bin
	$(LD) -r -b binary -o $@ installer.bin

clean:
	$(DEL_FILE) $(TARGETS) installer.bin installer.o

install: $(TARGETS)
	@mkdir -p $(INSTALL_PREFIX)/sbin
	install -m 0755 pkgtool $(INSTALL_PREFIX)/usr/sbin

hostinstall:
	@mkdir -p $(INSTALL_PREFIX)/usr/bin
	install -m 0755 mkpkg $(INSTALL_PREFIX)/usr/bin
