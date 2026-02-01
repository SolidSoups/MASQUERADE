#!/bin/sh
printf '\033c\033]0;%s\a' Masquerade
base_path="$(dirname "$(realpath "$0")")"
"$base_path/MasqueradeV2_linux.x86_64" "$@"
