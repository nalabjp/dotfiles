# dotfiles

## 初回セットアップ

Homebrew をインストールした macOS で、次のコマンドを実行します。

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew install chezmoi
chezmoi init --apply nalabjp/dotfiles
```

`chezmoi init` の途中で `machine name (maui or capri)` と表示されたら、
対象マシンに応じて `maui` または `capri` を入力します。パッケージを増減
したい場合は `.chezmoidata.yaml` の対象ホストのリストを編集してから
`chezmoi apply` を実行してください。

Karabiner の設定は、GUI から変更した内容が維持されるよう、ソース内の
`karabiner/` への symlink として管理しています。

## ~/.zshrc.local の暗号化

`.zshrc.local.maui.enc` は今回移行していません。実機で一度だけ次の手順を
実行してください。

```sh
brew install age
age-keygen -o ~/.config/chezmoi/key.txt
# .chezmoi.toml.tmpl の age ブロックを有効化し、recipient に公開鍵を設定
ansible-vault view ~/src/nalabjp/dotfiles/.zshrc.local.maui.enc \
  --vault-password-file ~/.ansible-vault > ~/.zshrc.local
chezmoi add --encrypt ~/.zshrc.local
# 確認後、リポジトリから .zshrc.local.maui.enc と ~/.ansible-vault を削除
```
