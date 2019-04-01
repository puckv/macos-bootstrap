#!/usr/bin/env bash
set -euo pipefail
. ${0%/*}/../.functions.sh

H1 "Installing dotfiles to home directory"

readlndef "https://github.com/puckv/dotfiles/archive/master.tar.gz" "Confirm or change dotfiles archive URL"
curl -sSL "$REPLY" | tar zxf - -C ~/ --strip-components=1
if [[ -f ~/.init-dotfiles.sh ]]; then
    ~/.init-dotfiles.sh
    rm ~/.init-dotfiles.sh
fi
