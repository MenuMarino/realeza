@echo off
REM One-time setup: enables the compression hook, installs LFS and ffmpeg

git config core.hooksPath .hooks
git lfs install

where ffmpeg >nul 2>nul
if %errorlevel% neq 0 (
  echo Installing ffmpeg...
  winget install --id Gyan.FFmpeg -e --accept-source-agreements --accept-package-agreements
  echo Restart your terminal for ffmpeg to be available.
)

echo Setup complete — clips will be auto-compressed on commit.
