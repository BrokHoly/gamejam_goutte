#!/bin/sh
printf '\033c\033]0;%s\a' GameJam_Goutte
base_path="$(dirname "$(realpath "$0")")"
"$base_path/GameJam_Goutte.x86_64" "$@"
