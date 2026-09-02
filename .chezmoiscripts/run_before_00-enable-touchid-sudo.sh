#!/bin/bash
set -euo pipefail

# sudo を Touch ID で通す（apply 中に何度もパスワードを聞かれないようにする）。
# tmux/screen 内でも効かせるため pam_reattach があれば併用する。
pam_local="/etc/pam.d/sudo_local"

if ! grep -q 'sudo_local' /etc/pam.d/sudo 2>/dev/null; then
  echo "warning: /etc/pam.d/sudo が sudo_local を include していません（macOS 14 未満）。Touch ID の設定はスキップします" >&2
  exit 0
fi

desired="# Managed by chezmoi"$'\n'
for __pam_prefix in /opt/homebrew /usr/local; do
  if [ -f "${__pam_prefix}/lib/pam/pam_reattach.so" ]; then
    desired+="auth       optional       ${__pam_prefix}/lib/pam/pam_reattach.so"$'\n'
    break
  fi
done
desired+="auth       sufficient     pam_tid.so"$'\n'

if [ "$(cat "${pam_local}" 2>/dev/null || true)" = "${desired}" ]; then
  exit 0
fi

echo "==> Touch ID for sudo を設定します（${pam_local}）"
printf '%s' "${desired}" | sudo tee "${pam_local}" > /dev/null
sudo chmod 644 "${pam_local}"
