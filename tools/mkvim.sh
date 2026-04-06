[ -d "vim" ] || git clone https://github.com/vim/vim 
cd vim
make distclean
export PKG_CONFIG_PATH=
export PKG_CONFIG_LIBDIR=
export CFLAGS="-O2 -march=native -mtune=native -fomit-frame-pointer -fno-semantic-interposition -fdata-sections -ffunction-sections -fno-plt -fwrapv"
export LDFLAGS="-s -Wl,-O1,--gc-sections,--as-needed,--strip-all"

./configure --disable-acl --disable-year2038 --disable-darwin --disable-smack --disable-selinux --disable-xattr --disable-xsmp --disable-xsmp-interact --disable-gpm --disable-sysmouse --disable-socketserver --disable-autoservername --disable-gnome-check --disable-gtk2-check --disable-gtk3-check --disable-motif-check --disable-gtktest --disable-sysmouse --disable-canberra --disable-libsodium --disable-arabic --disable-rightleft --disable-netbeans --enable-multibyte --disable-xim --disable-fontset --enable-clipboard --enable-gui=no --disable-icon-cache-update --disable-desktop-database-update --enable-cscope --disable-cryptv --disable-nls --disable-sysmouse --enable-python3interp=yes --enable-terminal --without-wayland --with-x --without-gnome --with-vim-name=vim --with-ex-name=ex --with-view-name=view

make -j$(nproc)
sudo make install
cd ..
