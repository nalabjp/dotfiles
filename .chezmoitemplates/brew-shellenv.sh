# brew を PATH に載せる（初回 apply 時はユーザのシェルにまだ載っていない）
for __brew_prefix in /opt/homebrew /usr/local; do
  if [ -x "${__brew_prefix}/bin/brew" ]; then
    eval "$("${__brew_prefix}/bin/brew" shellenv)"
    break
  fi
done
unset __brew_prefix
