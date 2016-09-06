# command line stack
show_buffer_stack() {
  POSTDISPLAY="
stack: $LBUFFER"
  zle push-line-or-edit
}
zle -N show_buffer_stack

# # path with fzf
function fzf-path() {
  local filepath="$(find . | grep -v '/\.' | fzf --prompt 'PATH>')"
  [ -z "$filepath" ] && return
  if [ -n "$LBUFFER" ]; then
    BUFFER="$LBUFFER$filepath"
  else
    if [ -d "$filepath" ]; then
      BUFFER="cd $filepath"
    elif [ -f "$filepath" ]; then
      BUFFER="$EDITOR $filepath"
    fi
  fi
  CURSOR=$#BUFFER
}
zle -N fzf-path

# ag and vim
function agvim () {
  vim $(ag $@ | fzf --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
}

# ag -h and vim
function aghvim () {
  vim $(agh $@ | fzf --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
}

# git grep and vim
function ggrvim () {
  vim $(git grep -n $@ | fzf --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
}

# rake
_cachefile_updated_at() {
  echo $(stat -f%m .rake_tasks)
}

_rakefile_updated_at() {
  echo $(stat -f%m Rakefile)
}

_gemfile_updated_at() {
  echo $(stat -f%m Gemfile)
}

_generate_cachefile() {
  rake --silent --tasks 2> /dev/null | cut  -f 2 -d " " > .rake_tasks
}

_rake() {
  if [ -f Rakefile ]; then
    if [ ! -f .rake_tasks ] || \
       [ "`cat .rake_tasks | wc -l`" = "0" ] || \
       [ `_cachefile_updated_at` -lt `_rakefile_updated_at` ] || \
       [ -f Gemfile -a `_cachefile_updated_at` -lt `_gemfile_updated_at` ]; then
      _generate_cachefile
    fi
    compadd `cat .rake_tasks`
  fi
}

compdef _rake rake

# w3m config
# w3m google search
function ggrks() {
  local str opt
  if [ $ != 0 ]; then
    for i in $*; do
      str="$str+$i"
    done
    str=`echo $str | sed 's/^\+//'`
    opt='search?num=50&h1=ja&lr=lang_ja'
    opt="${opt}&q=${str}"
  fi
  w3m http://www.google.co.jp/$opt
}

# cache git status
function cache_git_status () {
  [ -d .git ] && (git status &>/dev/null &)
}

function re-prompt() {
    zle .reset-prompt
    zle .accept-line
}
zle -N accept-line re-prompt
