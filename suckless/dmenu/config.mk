# dmenu version
VERSION = 5.3

# paths
PREFIX = /usr
MANPREFIX = $(PREFIX)/share/man

X11INC = /usr/X11R6/include
X11LIB = /usr/X11R6/lib

# freetype
FREETYPELIBS = -lfontconfig -lXft
FREETYPEINC = /usr/include/freetype2

# includes and libs
INCS = -I$(X11INC) -I$(FREETYPEINC)
LIBS = -L$(X11LIB) -lX11 $(XINERAMALIBS) $(FREETYPELIBS) -lm

# flags
CPPFLAGS = -D_DEFAULT_SOURCE -D_BSD_SOURCE -D_XOPEN_SOURCE=700 -D_POSIX_C_SOURCE=200809L -DVERSION=\"$(VERSION)\" $(XINERAMAFLAGS) -O3 -pipe -mtune=native -march=native -fno-semantic-interposition -fomit-frame-pointer
CFLAGS   = -std=c99 -pedantic -Wall $(INCS) $(CPPFLAGS)
LDFLAGS  = $(LIBS)

# compiler and linker
CC = cc
