_gwa() {
  local branch=$1
  git worktree add gwt-$branch $branch
  cd gwt-$branch/vendor
  ln -s ../../vendor/bundle bundle
  bundle install --path=vendor/bundle
  cd ..
}

_gwac() {
  local branch=$1
  local base=${2:-upstream/release}
  git branch $branch $base
  _gwa $branch
}
