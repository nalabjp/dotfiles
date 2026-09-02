# dotfiles

## 初回セットアップ（クリーンな Mac）

```sh
sudo -v
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$(mktemp -d)" \
  init --use-builtin-git=true --source="$HOME/src/nalabjp/dotfiles" \
  --apply nalabjp/dotfiles
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

`--source` で clone 先（= source ディレクトリ）を ghq の管理下に揃えています。
設定ファイル生成より前に clone するため、初回だけはフラグで指定します
（2 回目以降は `.chezmoi.toml.tmpl` の `sourceDir` が効きます）。

`chezmoi init` の途中で `machine name (maui or capri)` と表示されたら、
対象マシンに応じて `maui` または `capri` を入力します。検証したいブランチを
指定する場合は `--branch <ブランチ名>` を追加してください。

Karabiner の設定は、GUI から変更した内容が維持されるよう、ソース内の
`karabiner/` への symlink として管理しています。

## sudo の Touch ID 認証

セットアップの最初に Touch ID による sudo 認証を設定します。macOS 14 未満では
対応する `sudo_local` がないためスキップされます。tmux 内でも有効にするには
`pam-reattach`（Brewfile に含まれる）が必要で、インストール後の次回 `chezmoi apply`
で設定に自動的に追記されます。

## 日常運用

chezmoi が参照するのは source ディレクトリ（`chezmoi source-path`）だけです。
chezmoi の既定は `~/.local/share/chezmoi` ですが、このリポジトリでは
`.chezmoi.toml.tmpl` の `sourceDir` で `~/src/nalabjp/dotfiles` を指定しているため、
ghq 管理下の clone をそのまま編集できます。別の場所に clone したものを編集しても
反映されないので注意してください。

```sh
chezmoi source-path            # source ディレクトリの場所
chezmoi cd                     # source ディレクトリに移動（exit で戻る）
chezmoi update                 # source を git pull して apply（普段はこれ）
chezmoi diff                   # 適用前に差分を確認
chezmoi apply                  # 適用（-v で詳細、-n で dry-run）
chezmoi data                   # テンプレートに渡されるデータを表示
chezmoi edit ~/.zshrc          # source 側の対応ファイルを編集
chezmoi add ~/.gitconfig       # 実機側の変更を source に取り込む
chezmoi status                 # 未適用の変更を一覧
```

パッケージを増減する場合は、source ディレクトリの `.chezmoidata.yaml` で対象
ホストのリストを編集し、`chezmoi apply` します。変更を他の機体にも反映するには
commit して push し、各機体で `chezmoi update` を実行します。

```sh
chezmoi cd
$EDITOR .chezmoidata.yaml
git commit -am "Add foo" && git push
exit
chezmoi apply
```

テンプレートの展開結果だけを確認したい場合は次のとおりです。

```sh
chezmoi cat ~/.config/homebrew/Brewfile          # 実際に配置される内容を表示
echo '{{ .machine }}' | chezmoi execute-template # 任意のテンプレートを試す
```

既に `~/.local/share/chezmoi` で運用している機体は、次の手順で source ディレクトリを
移せます（未 push の変更が無いことを確認してから実行してください）。

```sh
chezmoi git -- status          # 未 push の変更が無いか確認
rm -rf ~/.local/share/chezmoi
chezmoi init --source="$HOME/src/nalabjp/dotfiles" nalabjp/dotfiles
chezmoi source-path            # ~/src/nalabjp/dotfiles になっていること
chezmoi diff && chezmoi apply
```

その他のコマンドやテンプレート記法は公式リファレンスを参照してください。

- ユーザーガイド: https://www.chezmoi.io/user-guide/command-overview/
- コマンドリファレンス: https://www.chezmoi.io/reference/commands/
- テンプレート: https://www.chezmoi.io/reference/templates/
- 設定ファイル: https://www.chezmoi.io/reference/configuration-file/

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

グローバルの既定バージョンは `.chezmoidata.yaml` の `runtimes` で宣言します
（`shared` に共通、`maui` / `capri` にマシン固有。マシン側が `shared` を上書きします）。
`~/.config/mise/config.toml` はこの宣言から生成されるため、`mise use -g` で直接書き
換えると次の `chezmoi apply` で戻ります。バージョンを変えるときは `runtimes` を編集し、
apply 後に `mise install` してください。

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
