# Gaming Clips

A GitHub Pages site to archive and browse gaming clips with friends.

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

Outplayed clips work as-is — copy them keeping the original filename. Any `.mp4` works regardless of naming.

## Adding a new game

Just create a new folder under `clips/`. The filter dropdown updates automatically.

## Setup

1. Fork/clone this repo
2. Run `git lfs install`
3. Enable GitHub Pages (Settings → Pages → Source: `main`, folder: `/ (root)`)
4. Start adding clips!

## Git LFS

Video files use Git LFS. Free tier: 1 GB storage + 1 GB bandwidth/month.
