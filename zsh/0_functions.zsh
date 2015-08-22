function export_path_if_exists() {
    test -d "$1" && export PATH="$1:$PATH"
}
function source_if_exists() {
    test -f "$1" && source "$1"
}
function eval_if_exists() {
    test -f $(which $1) && eval "$2"
}
