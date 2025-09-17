#include ../optimization.mk
VERSION = 6.5

# paths
PREFIX = /usr/local
MANPREFIX = ${PREFIX}/share/man

X11INC = /usr/X11R6/include
X11LIB = /usr/X11R6/lib

FREETYPELIBS = -lfontconfig -lXft
FREETYPEINC = /usr/include/freetype2

# includes and libs
INCS = -I${X11INC} -I${FREETYPEINC}
LIBS = -L${X11LIB} -lX11 ${XINERAMALIBS} ${FREETYPELIBS}

# flags
CPPFLAGS += -D_DEFAULT_SOURCE -D_BSD_SOURCE -D_XOPEN_SOURCE=700L -DVERSION=\"${VERSION}\" ${XINERAMAFLAGS}
CFLAGS   += -std=c99 -pedantic -Wall -Wno-deprecated-declarations -O2 -march=native -mtune=native -fomit-frame-pointer -fno-semantic-interposition -fdata-sections -ffunction-sections ${INCS} ${CPPFLAGS}
LDFLAGS  += ${LIBS} -s -Wl,--gc-sections,--strip-all


CC = gcc
