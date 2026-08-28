#!/bin/bash
set -euo pipefail

brew_zsh="$(brew --prefix)/bin/zsh"
[ -x "${brew_zsh}" ] || { echo "skip: ${brew_zsh} not found" >&2; exit 0; }

grep -qxF "${brew_zsh}" /etc/shells || \
  echo "${brew_zsh}" | sudo tee -a /etc/shells > /dev/null

[ "${SHELL}" = "${brew_zsh}" ] || sudo chsh -s "${brew_zsh}" "${USER}"
