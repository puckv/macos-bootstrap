#!/usr/bin/env bash
set -euo pipefail
. ${0%/*}/../.functions.sh

H1 "Installing Tarsnap"
ORIGDIR=$(pwd)

tarsnaperr() {
  cd "$ORIGDIR"
  err "$@"
}

H2 "Downloading..."
TARSNAP_TMPDIR=$(mktemp -d)
curl -Sso "$TARSNAP_TMPDIR/tarsnap-autoconf-1.0.39.tgz" https://www.tarsnap.com/download/tarsnap-autoconf-1.0.39.tgz
shasum -a256 "$TARSNAP_TMPDIR/tarsnap-autoconf-1.0.39.tgz" | grep -q 5613218b2a1060c730b6c4a14c2b34ce33898dd19b38fb9ea0858c5517e42082 || tarsnaperr "Could not verify tarsnap-autoconf-1.0.39.tgz checksum"
cd "$TARSNAP_TMPDIR"
tar xzf tarsnap-autoconf-1.0.39.tgz || tarsnaperr "Error unpacking tarsnap-autoconf-1.0.39.tgz"
cd tarsnap-autoconf-1.0.39

H2 "Compiling..."
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"
./configure > /dev/null || tarsnaperr "Could not configure tarsnap makefile"
make all > /dev/null || tarsnaperr "Error compiling tarsnap"

H3 "Installing..."
sudo make install >/dev/null || tarsnaperr "Error installing tarsnap"
