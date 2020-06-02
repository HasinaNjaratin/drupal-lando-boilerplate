# Composer template for Drupal projects

This project template provides a starter kit for managing your site
dependencies with [Composer](https://getcomposer.org/).


## Usage

First you need to [install composer](https://getcomposer.org/doc/00-intro.md#installation-linux-unix-osx).

> Note: The instructions below refer to the [global composer installation](https://getcomposer.org/doc/00-intro.md#globally).
You might need to replace `composer` with `php composer.phar` (or similar)
for your setup.

After that you clone this project and run

```
composer install
```

With `composer require ...` you can download new dependencies to your
installation.
Example:
```
cd some-dir
composer require drupal/devel:~1.0
```

Use `settings.local.php` to config local settings.

### How can I apply patches to downloaded modules?

If you need to apply patches (depending on the project being modified, a pull
request is often a better solution), you can do so with the
[composer-patches](https://github.com/cweagans/composer-patches) plugin.

To add a patch to drupal module foobar insert the patches section in the extra
section of composer.json:
```
"extra": {
    "patches": {
        "drupal/foobar": {
            "Patch description": "URL or local path to patch"
        }
    }
}
```

### Configuration split

Use config_split module to manage configurations

```
$config['config_split.config_split.dev']['status'] = TRUE;
$config['config_split.config_split.hors_prod']['status'] = FALSE;
$config['config_split.config_split.prod']['status'] = FALSE;
```
