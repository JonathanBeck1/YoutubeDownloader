#!/usr/bin/env bash
set -e

REPO="https://github.com/<JonathanBeck1>/YoutubeDownloader.git"
DEST="$HOME/Documents/YoutubeDownloader"

step() { printf "\\033[1;34m▶ %s\\033[0m\\n" "$1"; }

step "Installing dependencies…"
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
brew install yt-dlp ffmpeg git

step "Cloning / updating repo…"
if [ -d "$DEST/.git" ]; then
  git -C "$DEST" pull --ff-only
else
  git clone "$REPO" "$DEST"
fi

step "Setting execute permissions…"
chmod +x "$DEST"/*.command "$DEST"/*.sh

step "Creating download folders…"
mkdir -p "$DEST/downloads/videos" "$DEST/downloads/audio"

open "$DEST"

printf "\\n\\033[1;32m✅ All set!\\033[0m Launchers are in: $DEST\\n"
