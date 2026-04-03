#!/usr/bin/env python3
"""Scan clips/<game>/ directories and generate clips.json."""

import json, os, re
from datetime import datetime, timezone
from pathlib import Path

CLIPS_DIR = Path("clips")
OUT_FILE = Path("clips.json")

# Outplayed: "Game Name_MM-DD-YYYY_HH-mm-ss-ms.mp4"
OUTPLAYED_RE = re.compile(
    r"_(?P<m>\d{1,2})-(?P<d>\d{1,2})-(?P<y>\d{4})_\d{1,2}-\d{1,2}-\d{1,2}-\d+\.mp4$",
    re.IGNORECASE,
)


def parse_clip(path: Path) -> dict | None:
    rel = path.relative_to(".")
    parts = path.relative_to(CLIPS_DIR).parts

    # Only process files inside a game subfolder
    if len(parts) < 2:
        return None

    game = parts[0]
    m = OUTPLAYED_RE.search(path.name)
    if m:
        date = f"{m.group('y')}-{int(m.group('m')):02d}-{int(m.group('d')):02d}"
    else:
        ts = os.path.getmtime(path)
        date = datetime.fromtimestamp(ts, tz=timezone.utc).strftime("%Y-%m-%d")

    return {
        "file": f"https://media.githubusercontent.com/media/MenuMarino/realeza/main/{rel}",
        "game": game,
        "date": date,
        "title": path.stem.replace("_", " "),
    }


def main():
    clips = sorted(
        filter(None, (parse_clip(p) for p in CLIPS_DIR.rglob("*.mp4"))),
        key=lambda c: c["date"],
        reverse=True,
    )
    OUT_FILE.write_text(json.dumps(clips, indent=2))
    print(f"Generated {OUT_FILE} with {len(clips)} clip(s)")


if __name__ == "__main__":
    main()
