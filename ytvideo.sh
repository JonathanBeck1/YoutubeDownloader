ø#!/usr/bin/env bash
set -euo pipefail

read -rp "Paste YouTube Link (or type EXIT to quit): " url
[ "$url" = "EXIT" ] && exit 0

outdir="$(dirname "$0")/downloads/videos"
mkdir -p "$outdir"

yt-dlp \
  --no-playlist \
  --merge-output-format mp4 \
  -f "bv*[ext=mp4][vcodec^=avc1][height<=1080]+ba[ext=m4a]/b[ext=mp4]" \
  -o "$outdir/%(title)s.%(ext)s" \
  "$url"
