#!/bin/bash
# One-time setup: enables the compression hook and installs LFS
git config core.hooksPath .hooks
git lfs install
echo "✅ Setup complete — clips will be auto-compressed on commit."
