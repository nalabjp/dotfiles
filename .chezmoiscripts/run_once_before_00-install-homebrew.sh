#!/bin/bash
set -euo pipefail

# 既にインストール済みなら PATH に載せて終了（初回シェルでは shellenv 未評価）
for prefix in /opt/homebrew /usr/local; do
  if [ -x "${prefix}/bin/brew" ]; then
    exit 0
  fi
done

# sudo 資格情報がキャッシュ済みなら無人で進める。apply が終わる（= 親の chezmoi が終了する）まで
# 50 秒ごとにタイムスタンプを更新して 5 分のキャッシュ切れを防ぐ。
if sudo -n true 2>/dev/null; then
  parent="${PPID}"
  ( while kill -0 "${parent}" 2>/dev/null; do
      sudo -n true 2>/dev/null || true
      sleep 50
    done ) &
  disown
  export NONINTERACTIVE=1
fi

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
