@echo off
REM One-time setup: enables the compression hook, installs LFS and ffmpeg

git config core.hooksPath .hooks
git lfs install

REM Check git identity
git config --global user.name >nul 2>nul
if %errorlevel% neq 0 (
  set /p username="Enter your Git username: "
  set /p email="Enter your Git email: "
  git config --global user.name "%username%"
  git config --global user.email "%email%"
)

REM Check ffmpeg
where ffmpeg >nul 2>nul
if %errorlevel% neq 0 (
  echo Installing ffmpeg...
  winget install --id Gyan.FFmpeg -e --accept-source-agreements --accept-package-agreements
  echo Restart your terminal for ffmpeg to be available.
)

echo Setup complete — clips will be auto-compressed on commit.
