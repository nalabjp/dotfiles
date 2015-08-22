# php-fpm
export PATH="$(brew --prefix)/sbin:$PATH"

# php dev
phpdev() {
  mysql.server start
  php-fpm -D
  nginx
}
