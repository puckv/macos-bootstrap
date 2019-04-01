#!/bin/bash

if [[ -z "$PRIVATE_GPG_ID" ]]; then
  echo "No GPG key id found in \$PRIVATE_GPG_ID"
  exit 1
fi

if [[ -z "$1" ]]; then
  echo "Filename pattern required"
  exit 2
fi

echo Encrypting for "$PRIVATE_GPG_ID":
find -f . "$@" -type file -maxdepth 0 -exec echo " " {} \; -exec gpg -e -r "$PRIVATE_GPG_ID" {} \;
