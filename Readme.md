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
|`APACHE_SITE_CONF_SSL`|Virtual host ssl settings|sites-enabled/site-ssl.conf|
|`APACHE_CONF_CUSTOM`|[Custom](conf.d/custom.conf) Apache Settings, included in apache2.conf|conf-enabled/custom.conf|
|`APACHE_SSL_ENGINE`|SSLEngine|On|
|`APACHE_SSL_CERT_FILE`|SSLCertificateFile|/etc/apache/ssl/site.pem|
|`APACHE_SSL_KEY_FILE`|SSLCertificateKeyFile|/etc/apache/ssl/site.key|

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


## SSL
If you want to use ssl (https), copy cert and key to the machine and reference them with `APACHE_SSL_CERT_FILE` and `APACHE_SSL_KEY_FILE`
OR provide the files via volumes

### example docker run 
```bash
  docker run \
      -v ./cert.pem:/etc/apache/ssl/site.pem:ro \
      -v ./cert.key:/etc/apache/ssl/site.key:ro \
      jheimbach/apache
```

### example docker-compose 
```yaml
  webserver:
    image: jheimbach/apache:latest
    volumes:
    - ./cert.pem:/etc/apache/ssl/site.pem:ro
    - ./cert.key:/etc/apache/ssl/site.key:ro
```