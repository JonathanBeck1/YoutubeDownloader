#!/usr/bin/env bash
set -euo pipefail

read -rp "Paste YouTube Link (or type EXIT to quit): " url
[ "$url" = "EXIT" ] && exit 0

outdir="$(dirname "$0")/downloads/audio"
mkdir -p "$outdir"

yt-dlp \
  --no-playlist \
  -x --audio-format mp3 --audio-quality 0 \
  -o "$outdir/%(title)s.%(ext)s" \
  "$url"
