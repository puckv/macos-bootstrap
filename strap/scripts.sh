#!/usr/bin/env bash
set -euo pipefail
. ${0%/*}/../.functions.sh

H1 "Installing custom scripts"
sudo mkdir -p /usr/local/bin

H2 "hosts-update"
H3 "Installing..."
sudo cp ${0%/*}/../scripts/hosts-update.sh /usr/local/bin/hosts-update
if [[ ! -f "/etc/hosts_permanent" ]]; then
    H3 "Copying /etc/hosts to /etc/hosts_permanent"
    sudo cp /etc/hosts /etc/hosts_permanent
fi
H3 "Scheduling daily execution via launchd (logging to /var/log/hosts-update.log)"
if [[ $(sudo launchctl list | grep com.github.puckv.macos-bootstrap.hosts-update) && -f "/Library/LaunchDaemons/com.github.puckv.macos-bootstrap.hosts-update.plist" ]]; then
    H3 "Stopping already running launch agent"
    sudo launchctl unload /Library/LaunchDaemons/com.github.puckv.macos-bootstrap.hosts-update.plist
fi
sudo cp ${0%/*}/../scripts/assets/com.github.puckv.macos-bootstrap.hosts-update.plist /Library/LaunchDaemons/
sudo launchctl load /Library/LaunchDaemons/com.github.puckv.macos-bootstrap.hosts-update.plist

H2 "chrome-autoconfig"
H3 "Installing..."
sudo cp ${0%/*}/../scripts/chrome-autoconfig.sh /usr/local/bin/chrome-autoconfig
sudo mkdir -p /usr/local/etc
sudo cp ${0%/*}/../scripts/assets/chrome-autoconfig.json /usr/local/etc

H2 "shamir-sharing"
SHAMIR_TMPDIR="${TMPDIR}$(uuidgen)"
mkdir -p $SHAMIR_TMPDIR
H3 "Downloading..."
curl -sSL -o ${SHAMIR_TMPDIR}/macos-shamir-split https://github.com/puckv/shamir-sharing/releases/download/v1.0.0/macos-shamir-split
curl -sSL -o ${SHAMIR_TMPDIR}/macos-shamir-combine https://github.com/puckv/shamir-sharing/releases/download/v1.0.0/macos-shamir-combine
H3 "Verifying checksums..."
SHAMIR_VALID_SPLIT="037117a400f9bf76336985794913646f9ac0671eefa7e493d6244bfa963f2dbf"
SHAMIR_VALID_COMBINE="60f51a8c72125023c1ac1034ecf3c7456cbefa42b829b9acadb5806692f07189"
SHAMIR_SHA_SPLIT=$(shasum -p -a 256 $SHAMIR_TMPDIR/macos-shamir-split | cut -d' ' -f1)
SHAMIR_SHA_COMBINE=$(shasum -p -a 256 $SHAMIR_TMPDIR/macos-shamir-combine | cut -d' ' -f1)
if [[ "$SHAMIR_SHA_SPLIT" == "$SHAMIR_VALID_SPLIT" ]] \
&& [[ "$SHAMIR_SHA_COMBINE" == "$SHAMIR_VALID_COMBINE" ]]; then
    H3 "Installing..."
    sudo mv ${SHAMIR_TMPDIR}/macos-shamir-split /usr/local/bin/shamir-split
    sudo mv ${SHAMIR_TMPDIR}/macos-shamir-combine /usr/local/bin/shamir-combine
    sudo chmod +x /usr/local/bin/shamir-split /usr/local/bin/shamir-combine
else
    H2WARN "Checksums invalid. Not installing. Deleting downloaded files"
    H3 "macos-shamir-split downloaded sha256   : ${SHAMIR_SHA_SPLIT}"
    H3 "macos-shamir-split valid sha256        : ${SHAMIR_VALID_SPLIT}"
    H3 "macos-shamir-combine downloaded sha256 : ${SHAMIR_SHA_COMBINE}"
    H3 "macos-shamir-combine valid sha256      : ${SHAMIR_VALID_COMBINE}"
fi
rm -R "$SHAMIR_TMPDIR"

H2 "genusername"
USERGEN_TMPDIR="${TMPDIR}$(uuidgen)"
mkdir -p "$USERGEN_TMPDIR"
H3 "Downloading..."
curl -sSL -o ${USERGEN_TMPDIR}/genusername.js https://raw.githubusercontent.com/puckv/genusername/master/genusername.js
H3 "Verifying checksum..."
USERGEN_VALID="ef8c29b86ced73929882eef034a36ab29ac82cd64e40fb408b8838f2c044617f"
USERGEN_SHA=$(shasum -p -a 256 $USERGEN_TMPDIR/genusername.js | cut -d' ' -f1)
if [[ "$USERGEN_SHA" == "$USERGEN_VALID" ]]; then
    H3 "Installing..."
    (
        echo '#!/usr/local/bin/node'
        cat "$USERGEN_TMPDIR"/genusername.js
    ) | sudo tee /usr/local/bin/genusername > /dev/null
    sudo chmod +x /usr/local/bin/genusername
else
    H2WARN "Checksums invalid. Not installing. Deleting downloaded files"
    H3 "genusername.js downloaded sha256   : ${USERGEN_SHA}"
    H3 "genusername.js valid sha256        : ${USERGEN_VALID}"
fi
rm -R "$USERGEN_TMPDIR"

H2 "encpriv"
H3 "Installing..."
sudo cp ${0%/*}/../scripts/encpriv.sh /usr/local/bin/encpriv

H2 "assume-role"
H3 "Installing..."
sudo curl -sSL -o /usr/local/bin/assume-role https://raw.githubusercontent.com/puckv/assume-role/master/assume-role
sudo chmod +x /usr/local/bin/assume-role

H2 "gpaws"
H3 "Installing..."
sudo curl -sSL -o /usr/local/bin/gpaws https://raw.githubusercontent.com/puckv/gpaws/master/gpaws
sudo chmod +x /usr/local/bin/gpaws
