#!/usr/bin/env bash
set -euo pipefail
REPO="$HOME/.dotfiles"
cd "$REPO/packages"
for pkg in *; do
  [ -d "$pkg" ] || continue
  stow -v -R -t "$HOME" "$pkg"
done
