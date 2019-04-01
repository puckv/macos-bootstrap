#!/usr/bin/env bash
set -euo pipefail
. ${0%/*}/../.functions.sh

H1 "Installing brew formulas"
sudo -K

brew install openssl
brew install pinentry-mac
brew install gnupg
brew install jq
brew install python
brew install --ignore-dependencies tarsnapper
