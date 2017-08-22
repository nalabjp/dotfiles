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

# ag and nvim
function av () {
  nvim $(ag $@ | fzf --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
}

# ag -h and nvim
function ahv () {
  nvim $(agh $@ | fzf --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
}

# git grep and nvim
function gv () {
  nvim $(git grep -n $@ | fzf --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
}

# mdfind and nvim
function fv () {
  nvim $(mdfind "kMDItemDisplayName == *$@*" | fzf --query "$LBUFFER")
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

function _vim() {nvim ${${=*/:/ +}/:*}}
