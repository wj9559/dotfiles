#!/usr/bin/env bash

err() {
    echo `tput bold; tput setaf 1`"[-] ERROR: ${*}"`tput sgr0` >&2
}

warn() {
    echo `tput bold; tput setaf 1`"[!] WARNING: ${*}"`tput sgr0` >&2
}

msg() {
    echo `tput bold; tput setaf 2`"[+] ${*}"`tput sgr0`
}
