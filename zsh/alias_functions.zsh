_gwa() {
  local branch=$1
  local base=${2:-release}
  git branch $branch upstream/$base
  git worktree add gwt-$branch $branch
  cd gwt-$branch/vendor
  ln -s ../../vendor/bundle bundle
  bundle install --path=vendor/bundle
  cd ..
}
