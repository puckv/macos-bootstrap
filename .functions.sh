#!/usr/bin/env bash

RED='\033[0;31m'
GREEN='\033[0;32m'
GRAY='\033[0;90m'
CYAN='\033[0;36m'
YELLOW='\033[0;33m'
NC='\033[0m'

H1() {
    echo -e "${YELLOW}>>> $@${NC}"
}

H2() {
    echo -e "${CYAN} >> $@${NC}"
}

H3() {
    echo -e "${GRAY}  > $@${NC}"
}

H2WARN() {
    echo -e "${RED} >> $@${NC}"
}

yesno() {
    printf "${GREEN}  > $@ ${NC}[Y/n]: "
    read -n 1 -r
    if [[ ! -z "$REPLY" ]]; then echo; fi
    if [[ $REPLY =~ ^[yY] || -z "$REPLY" ]]; then
        YESNO=true
    else
        YESNO=false
    fi
}

noyes() {
    printf "${GREEN}  > $@ ${NC}[y/N]: "
    read -n 1 -r
    if [[ ! -z "$REPLY" ]]; then echo; fi
    if [[ $REPLY =~ ^[yY] ]]; then
        YESNO=true
    else
        YESNO=false
    fi
}

reqyes() {
    noyes "Did you write down the recovery key in a secure location?"
    if [[ "$YESNO" == true ]]; then
        H3 "Great!"
    else
        H3 "You should really do it! I'll wait..."
        sleep 5
        reqyes
    fi
}

readln() {
    printf "${GREEN}  > $@${NC}: "
    read -r
}

readlndef() {
    local DEFAULT=$1
    shift
    printf "${GREEN}  > $@${NC} [${DEFAULT}]: "
    read -r
    if [[ -z "$REPLY" ]]; then
        REPLY="$DEFAULT"
    fi
}

err() {
    if [[ -z "${1-}" ]]; then
        echo -e "${RED}>>> Error: failed${NC}"
    else
        echo -e "${RED}>>> Error: $@${NC}"
    fi
    exit 1
}

