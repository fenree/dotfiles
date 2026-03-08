#!/bin/sh
DPI=96
SIZE=20

FONT_PATH="/usr/share/fonts"
X11_FONT_PATH="${FONT_PATH}/X11/misc/"
FONT="IosevkaNerdFontMono-Regular"

sudo find "${X11_FONT_PATH}" -name "${FONT}.[bp][cd]f*" -delete

otf2bdf -r ${DPI} -p ${SIZE} ${FONT_PATH}/TTF/${FONT}.ttf -o ${FONT}.bdf 

bdftopcf ${FONT}.bdf | gzip > ${FONT}.pcf.gz

sudo mv ${FONT}.pcf.gz /usr/share/fonts/X11/misc/

#sudo mkfontdir "${X11_FONT_PATH}"
list=""
(for pcf in ${X11_FONT_PATH}/*.pcf.gz; do
	printf '%s\n' $(gunzip -c ${pcf} | strings | awk '/^-/ {print; exit}') 

done) | sudo tee -a ${X11_FONT_PATH}/fonts.dir



xset fp rehash

cat ${FONT_PATH}/X11/misc/fonts.dir
