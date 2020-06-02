This project template provides a starter kit to manage drupal project with [Lando](https://docs.lando.dev/config/drupal8.html) and [xdebug](https://xdebug.org/) set.
It is set with most popular and used modules for drupal, such as [devel](https://www.drupal.org/project/devel), [config_split](https://www.drupal.org/project/config_split), [paragraphs](https://www.drupal.org/project/paragraphs), etc ...

## TODO

Add unversionned.sql to gitignore and replace it as the project progresses.

## Lando

First you need to [install lando](https://github.com/lando/lando/releases).

> Note: You might need to install `docker` if you do not yet install it for your setup.

After that you clone this project and run

```
lando start
```

> Note: Drupal will avalaible through [`http://drupal-lando-boilerplate.lndo.site:8000/`](http://drupal-lando-boilerplate.lndo.site).

## Composer

To install php components, run

```
lando composer install
```

With `composer require ...` you can download new dependencies to your
installation.
Example:
```
lando composer require drupal/devel:~1.0
```

To check component version, run

```
lando composer outdated
```

To update composer packages, run

```
lando composer update
```

##### How can I apply patches to downloaded modules?

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

Use _/patches_ directory to put patches files.

## Xdebug

This project has a php with an xdebug installed and activated, ready to use.

To set it up with the IDE : [Lando + xdebug + phpstorm](https://docs.lando.dev/guides/lando-phpstorm.html#debugging-drush-commands)


## Configuration split

Use [config_split](https://www.drupal.org/project/config_split) module to manage configurations.

There are three splits of configurations :
- dev : related to developpement environnement (_/config/splits/dev_)
- hors_prod : related to hors_prod environnement (_/config/splits/hors_prod_)
- prod : related to prod environnement (_/config/splits/prod_)

```
$config['config_split.config_split.dev']['status'] = TRUE;
$config['config_split.config_split.hors_prod']['status'] = FALSE;
$config['config_split.config_split.prod']['status'] = FALSE;
```

To import

```
lando drush cim -y
```

To export

```
lando drush csex -y
```


## Translations

You need to manage po files to configure multilanguage site case.

Translations directory is stored (configured) _/config/translations_

To check for updates

```
lando drush locale-check
```

To update

```
lando drush locale-update
```

## Custom commands

To reinstall composer package, remove vendor, core and contrib modules/themes :

```
lando drush reinstall
```

To install or update local environnement : install new components, update database, import configurations, etc ...

```
lando drush local-sync
```

To reset database

```
lando drush db-import unversionned.sql
```
