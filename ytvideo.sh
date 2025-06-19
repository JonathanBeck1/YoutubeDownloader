ø#!/usr/bin/env bash
set -euo pipefail

read -rp "Paste YouTube Link (or type EXIT to quit): " url
[ "$url" = "EXIT" ] && exit 0

outdir="$(dirname "$0")/downloads/videos"
mkdir -p "$outdir"

yt-dlp \
  --no-playlist \
  -f "bestvideo[ext=mp4][height<=1080]+bestaudio[ext=m4a]/best[ext=mp4][height<=1080]" \
  -o "$outdir/%(title)s.%(ext)s" \
  "$url"
