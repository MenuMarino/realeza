# Realeza

## Setup
1. Clone this repo
2. Run the one-time setup (installs LFS and enables auto-compression):
   - **Mac/Linux:** `./setup.sh`
   - **Windows:** double-click `setup.bat` or run `setup.bat` in cmd

## How it works
1. Drop `.mp4` files into a game folder under `clips/` (e.g. `clips/lol/`)
2. Push to the repo
3. A GitHub Action generates `clips.json` from the folder structure
4. The page renders a filterable video gallery

## Adding clips
Put your clips in the right game folder:

```
clips/
├── lol/
├── valorant/
├── minecraft/
└── <new-game>/       ← just create a folder, it auto-appears as a filter
```

**Windows shortcut:** double-click `upload.bat` — pick your clips, pick the game, done.

Outplayed clips work as-is — copy them keeping the original filename. Any `.mp4` works regardless of naming.

## Adding a new game
Just create a new folder under `clips/`. The filter dropdown updates automatically.

## Git LFS
Video files use Git LFS. Free tier: 1 GB storage + 1 GB bandwidth/month.

## Auto-compression
Clips are automatically compressed to 720p on commit (requires [ffmpeg](https://ffmpeg.org/)).
- **Mac:** `brew install ffmpeg`
- **Windows:** download from [ffmpeg.org](https://ffmpeg.org/download.html) or run `winget install ffmpeg`

If ffmpeg isn't installed, the original file is kept as-is.
