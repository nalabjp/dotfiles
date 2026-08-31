#!/bin/bash
set -euo pipefail
# vim-plug が使う ~/.vim（配下に管理ファイルが無いため chezmoi が作らない）
mkdir -p "${HOME}/.vim"
