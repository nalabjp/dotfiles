# dotfiles

## 初回セットアップ（クリーンな Mac）

```sh
sudo -v
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$(mktemp -d)" \
  init --use-builtin-git=true --apply nalabjp/dotfiles
```

1行目で管理者パスワードを一度だけ入力します。Homebrew のインストールに
sudo が必要ですが、apply 中は自動で資格情報のキャッシュが延長されます。
`-b "$(mktemp -d)"` により bootstrap 用 chezmoi は一時ディレクトリに置かれる
ため、後始末は不要です。以降は Brewfile 経由で入る Homebrew 版 chezmoi を
使用します。

`--use-builtin-git=true` は、Xcode Command Line Tools 未導入時に
`/usr/bin/git` スタブが CLT のインストールダイアログを表示するのを避ける
ための指定です。clone は設定ファイル生成より前に実行されるため、設定ファイル
ではなくフラグで指定します。

`chezmoi init` の途中で `machine name (maui or capri)` と表示されたら、
対象マシンに応じて `maui` または `capri` を入力します。検証したいブランチを
指定する場合は `--branch <ブランチ名>` を追加してください。パッケージを増減
したい場合は `.chezmoidata.yaml` の対象ホストのリストを編集してから
`chezmoi apply` を実行してください。

Karabiner の設定は、GUI から変更した内容が維持されるよう、ソース内の
`karabiner/` への symlink として管理しています。

## Neovim の Python provider

`~/.local/share/nvim/venv` に専用の Python 仮想環境を作成し、
`g:python3_host_prog` からその環境を使用します。Homebrew の Python が
メジャーアップデートされると仮想環境が壊れることがあるため、次のコマンドで
作り直してください。

```sh
rm -rf ~/.local/share/nvim/venv
"$(brew --prefix)/bin/python3" -m venv ~/.local/share/nvim/venv && \
  ~/.local/share/nvim/venv/bin/pip install --upgrade pip pynvim
```

## ~/.zshrc.local の暗号化

`.zshrc.local.maui.enc` を age で管理する場合は、実機で次の手順を実行します。

1. `age` をインストールして鍵を1組作成します。標準出力に表示される
   `Public key: age1...` を控えてください。`key.txt` は秘密鍵なので
   リポジトリには入れず、1Password などにも保管します。

```sh
brew install age
age-keygen -o ~/.config/chezmoi/key.txt
```

2. `.chezmoi.toml.tmpl` の age ブロックのコメントを外し、`recipient` に
   控えた公開鍵を設定して `chezmoi init` で設定を再生成します。
3. maui（`~/.ansible-vault` がある機体）で、旧暗号文を復号して配置します。

```sh
ansible-vault view ~/src/nalabjp/dotfiles/.zshrc.local.maui.enc \
  --vault-password-file ~/.ansible-vault > ~/.zshrc.local
```

4. `.zshrc.local` を chezmoi の暗号化ソースに追加します。

```sh
chezmoi add --encrypt ~/.zshrc.local
```

5. `chezmoi cat ~/.zshrc.local` で復号できることを確認します。
6. リポジトリから `.zshrc.local.maui.enc` を削除し、実機から
   `~/.ansible-vault` も削除してコミットします。
7. 新しい機体では `~/.config/chezmoi/key.txt` を復元しておけば、
   `chezmoi apply` で自動的に復号されます。`.chezmoiignore` により capri
   には配置されません。
