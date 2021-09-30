#!/bin/bash -e

TMPDIR="$(mktemp -d)"
CURRENT_DIR="$PWD"
cd "$TMPDIR" || exit 1
echo "[+] Downloading dictionaries ..."
wget -r -l 1 http://openlab.ring.gr.jp/skk/dic/
cd openlab.ring.gr.jp/skk/dic/

echo "[+] Checking file integrity ... "
md5sum -c -- *.md5
echo "[+] Removing unneeded files ... "
rm -v -- *.md5 *.html* *.tar.*

for i in *.gz; do
    echo "[+] Decompressing ${i} ..."
    gunzip "$i"
done

echo "[+] Copying dictionaries ... "
cp -v -- * "$CURRENT_DIR/"
cd "$CURRENT_DIR"

echo "[+] Cleaning up ... "
rm -rv "$TMPDIR"
