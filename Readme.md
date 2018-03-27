# Docker Apache
Apache docker container with customizable configuration

The following (additional) Modules are enabled:
 - rewrite
 - socache_shmcb
 - ssl
 - proxy
 - proxy_fcgi

## ENV
The following env_vars are available

### Apache Settings
|Envvar|Setting|Default|
|---|---|---|
|`APACHE_LOCK_DIR`|Lock Dir|/var/lock/apache2|
|`APACHE_PID_FILE`|pid file|/var/run/apache2.pid|
|`APACHE_RUN_USER`|user who is running apache|www-data|
|`APACHE_RUN_GROUP`|usergroup who is running apache|www-data|
|`APACHE_LOG_DIR`|apache log dir|/var/log/apache2|
|`APACHE_SERVER_NAME`|ServerName|localhost|
|`APACHE_CONF_SITE`|Virtual host settings|sites-enabled/site.conf|
|`APACHE_CONF_CUSTOM`|Custom Apache Settings, included in apache2.conf|conf-enabled/custom.conf|

### Virtual Host settings
|Envvar|Setting|Default|
|---|---|---|
|`APACHE_SITE_ADMIN`|`ServerAdmin`|webmaster@localhost|
|`APACHE_SITE_NAME`|`ServerName`|`$APACHE_SERVER_NAME` (localhost)|
|`APACHE_SITE_ROOT`|`DocumentRoot`|/var/www/html|
|`APACHE_SITE_ALIASES`|`ServerAlias`|`$APACHE_SITE_NAME` (localhost)|

## PHP Ready
PHP-ready (just spin a php-fpm container up)
php-files are send via fast_cgi to another container with the Standardname `php` editable via `PHP_SERVER` env_var

## Todos
 - ssl-configs