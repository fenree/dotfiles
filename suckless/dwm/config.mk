# dwm version
VERSION = 6.5

# Customize below to fit your system

# paths
PREFIX = /usr/local

X11INC = /usr/X11R6/include
X11LIB = /usr/X11R6/lib

# freetype
FREETYPELIBS = -lfontconfig -lXft
FREETYPEINC = /usr/include/freetype2

# includes and libs
INCS = -I${X11INC} -I${FREETYPEINC}
LIBS = -L${X11LIB} -lX11 ${XINERAMALIBS} ${FREETYPELIBS}

# flags
CPPFLAGS = -D_DEFAULT_SOURCE -D_BSD_SOURCE -D_XOPEN_SOURCE=700L -DVERSION=\"${VERSION}\" -march=native -mtune=native -pipe -fomit-frame-pointer -fno-semantic-interposition
CFLAGS   = -std=c99 -pedantic -Wall -Wno-deprecated-declarations -O3 ${INCS} ${CPPFLAGS}
LDFLAGS  = ${LIBS}

# compiler and linker
CC = gcc
