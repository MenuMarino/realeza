# Realeza

## Setup
1. Install [Git Bash](https://git-scm.com/install/windows)
2. Clone this repo: `git clone https://github.com/MenuMarino/realeza.git`
2. Run the one-time setup (installs LFS and enables auto-compression):
   - **Mac/Linux:** `./setup.sh`
   - **Windows:** double-click `setup-windows.bat` or run `setup-windows.bat` in cmd

## How it works
1. Add `.mp4` clips (see options below)
2. Push to the repo
3. A GitHub Action generates the clip index and deploys the page
4. The page renders a filterable video gallery

## Adding clips

### Option 1: Upload tool (Windows)
1. Double-click `upload-clips.bat`
2. Select one or more `.mp4` files from anywhere on your PC
3. Pick a game from the dropdown or type a new game name
4. Click Upload — compression, commit, and push happen automatically

### Option 2: Manual
1. Copy your `.mp4` files into the right game folder under `clips/`
2. Commit and push:
   ```
   git add clips/
   git commit -m "add clips"
   git push
   ```

```
clips/
├── lol/
├── valorant/
├── minecraft/
└── <new-game>/       ← just create a folder, it auto-appears as a filter
```

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
