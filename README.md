# YouTubeDownloader (macOS)

![macOS](https://img.shields.io/badge/os-macOS-blue.svg) ![Shell Scripts](https://img.shields.io/badge/language-shell-green.svg) ![License: MIT](https://img.shields.io/badge/license-MIT-lightgrey.svg)

A dead-simple command-line utility for macOS that lets you **download either the full YouTube video (video + audio) *or* an audio-only MP3** in seconds. Powered by [yt-dlp](https://github.com/yt-dlp/yt-dlp) + `ffmpeg`, wrapped in friendly double-click launchers.

---

## ✨ Highlights

* **Two launchers:**

  * `video_audio.command` – saves an H.264 MP4 into `downloads/videos/`.
  * `audio.command` – saves a high-quality MP3 into `downloads/audio/`.
* **One-line installer:**

  ```bash
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/JonathanBeck1/YoutubeDownloader/main/install.sh)"
  ```
* **Playlist-safe** – every script passes `--no-playlist`, so only the pasted URL is processed.
* Clean output tree.
* Tested on macOS 12 Monterey → macOS 14 Sonoma.

---

## 📦 Folder Layout

```text
Documents/YoutubeDownloader/
├── video_audio.command   # double-click → MP4
├── audio.command         # double-click → MP3
├── ytvideo.sh            # backend script (video)
├── ytaudio.sh            # backend script (audio)
├── install.sh            # one-command bootstrap
├── downloads/
│   ├── videos/           # MP4 output
│   └── audio/            # MP3 output
├── LICENSE
└── README.md
```

---

## 🚀 Quick Start

### 1. Move the folder into Documents and RENAME the FILE YoutubeDownloader

Before installing, move the unzipped folder to:

```bash
~/Documents/YoutubeDownloader
```

This ensures no permission issues and Finder access.

### 2. Run the installer (copy & paste into Terminal)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/<your-user>/YoutubeDownloader/main/install.sh)"
```

The installer will:

1. Install / update **Homebrew** if missing
2. Install **yt-dlp**, **ffmpeg**, and **git**
3. Clone this repo to `~/Documents/YoutubeDownloader`
4. Set execute bits on `.command` & `.sh` files
5. Create the downloads folder structure
6. Open the folder in Finder

Then open **Finder → Documents → YoutubeDownloader** and double-click the launcher you need.

### 3. Manual usage (if preferred)

```bash
cd ~/Documents/YoutubeDownloader
./video_audio.command   # MP4 → downloads/videos/
./audio.command         # MP3 → downloads/audio/
```

Paste **one** YouTube link when prompted → file lands in the correct sub-folder.

---

## 🔐 macOS Privacy Permissions (Only First Time)

When you install and run for the first time, macOS may ask for:

1. **Access to your Documents folder**
   → Click **Allow** when prompted

2. **Full Disk Access for Terminal** (only if downloads silently fail):

   * Go to **System Settings → Privacy & Security → Full Disk Access**
   * Enable access for **Terminal**
   * Quit and reopen Terminal once

These permissions are **only needed once** and guarantee that downloads save correctly.

---

## 🔄 Updating

```bash
brew upgrade yt-dlp           # newest extractor
cd ~/Documents/YoutubeDownloader && git pull
```

---

## 🛠 Troubleshooting

| Symptom                           | Fix                                                                    |
| --------------------------------- | ---------------------------------------------------------------------- |
| `command not found: yt-dlp`       | Re-run the installer or `brew install yt-dlp`.                         |
| Entire playlist downloads         | Make sure you’re using scripts ≥ 2025-06-19 (contain `--no-playlist`). |
| Permission denied on double-click | `chmod +x *.command *.sh` once.                                        |
| File doesn’t appear in downloads  | Grant Terminal Full Disk Access (see above).                           |

---

## 🤝 Contributing

Issues & PRs welcome. Keep scripts POSIX-sh compatible, run `shellcheck *.sh`, and update docs.

---

## 📜 Disclaimer

This tool is provided **as-is for personal-backup and educational use only**.
Downloading YouTube content may violate YouTube’s Terms of Service and/or local copyright laws.
You are solely responsible for any content you download and any legal consequences that follow.

---

## ⚖️ License

Released under the **MIT License** – see `LICENSE` for full text.

---

### Appendix A – `install.sh`

```bash
#!/usr/bin/env bash
set -e

REPO="https://github.com/<your-user>/YoutubeDownloader.git"
DEST="$HOME/Documents/YoutubeDownloader"

step() { printf "\033[1;34m▶ %s\033[0m\n" "$1"; }

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

printf "\n\033[1;32m✅ All set!\033[0m Launchers are in: $DEST\n"
```

---

