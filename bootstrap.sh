#!/usr/bin/env bash
set -euo pipefail
. ${0%/*}/.functions.sh

H1 "This script will configure your macOS and install development tools."
yesno "Do you want to start?"; if ! "$YESNO"; then H2WARN "Bootstrap aborted"; exit 1; fi

${0%/*}/strap/macos.sh
${0%/*}/strap/dotfiles.sh
${0%/*}/strap/brew.sh
${0%/*}/strap/scripts.sh
${0%/*}/strap/tarsnap.sh
${0%/*}/strap/brew-formulas.sh
${0%/*}/strap/filevault.sh

H1 "Bootstrap finished"
H2WARN "Some of the changes require a logout/restart to make effect"
