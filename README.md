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

## asdf から mise への移行

`asdf` は Brewfile から外れているため、`brew bundle cleanup --force` の実行時に
自動でアンインストールされます。plugin とランタイム実体を含む `~/.asdf` は
Homebrew 管理外なので、不要になったら手動で削除してください。

```sh
rm -rf ~/.asdf
```

ランタイムは mise で入れ直します。各プロジェクトの `.tool-versions` と
`.ruby-version` はそのまま利用できます。グローバル設定は chezmoi 管理の
`~/.config/mise/config.toml` にあり、`.ruby-version` を読み込む設定も含まれています。
`~/.default-gems` は mise の `ruby.default_packages_file` の既定値としてそのまま
流用できますが、mise では deprecated 扱いです。

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
