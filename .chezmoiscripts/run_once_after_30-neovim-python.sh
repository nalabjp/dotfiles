#!/bin/bash
set -euo pipefail
venv="${HOME}/.local/share/nvim/venv"
[ -d "${venv}" ] || "$(brew --prefix)/bin/python3" -m venv "${venv}"
"${venv}/bin/pip" install --upgrade pip pynvim
