This project template provides a starter kit to manage drupal project with [Lando](https://docs.lando.dev/config/drupal8.html), [xdebug](https://xdebug.org/) and [grumphp](https://github.com/phpro/grumphp).
It is set with most popular and used modules for drupal, such as [devel](https://www.drupal.org/project/devel), [config_split](https://www.drupal.org/project/config_split), [paragraphs](https://www.drupal.org/project/paragraphs), etc ...

**Table of Contents**

- [Lando](#lando)
- [Drupal generator](#drupal-generator)
- [Composer](#composer)
- [Xdebug](#xdebug)
- [Configuration Split](#configuration-split)
- [Translations](#translations)
- [Custom commands](#custom-commands)
- [PHPCS](#phpcs)
- [Grumphp](#grumphp)

# Lando

First you need to [install lando](https://github.com/lando/lando/releases).

> Note: You might need to install `docker` if you do not yet install it for your setup.

After that you clone this project and run

```
lando start
```

> Note: Drupal will avalaible through [`http://drupal-lando-boilerplate.lndo.site:8080/`](http://drupal-lando-boilerplate.lndo.site:8080).

# Drupal generator

To init/create drupal website :

```
lando site-install
```

All parameters about site installation (site name, admin login, etc ...) are configured in _.lando/settings/site_config.sh_ file.

# Composer

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

#### How can I apply patches to downloaded modules?

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

# Xdebug

This project has a php with an xdebug installed and activated, ready to use.

To set it up with the IDE : [Lando + xdebug + phpstorm](https://docs.lando.dev/guides/lando-phpstorm.html#debugging-drush-commands)


# Configuration split

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


# Translations

You need to manage po files to configure multilanguage site case.

To check for updates

```
lando drush locale-check
```

To update

```
lando drush locale-update
```

# Custom commands

To reinstall composer package, remove vendor, core and contrib modules/themes :

```
lando composer-reset
```

To install or update local environment : install new components, update database, import configurations, etc ...

```
lando site-update
```

To reset database

```
lando drush db-import <your-dump>.sql
```

# Phpcs

Phpcs is necessary to control and continue coding in good practice.

The verification is done in the _/www/modules/custom_ directory.

- Run phpcs to list all php code style evaluations :

```
lando phpcs
```

- Run phpcsf to fix all php code style evaluations that can be fixed automatically :

```
lando phpcs-fix
```

- Run phpcs to summary php code style evaluations :

```
lando phpcs-summary
```

# Grumphp

[grumphp](https://github.com/phpro/grumphp) is used to check the quality of codes before commits.

[PhpLint](https://github.com/phpro/grumphp/blob/master/doc/tasks/phplint.md), [PhpUnit](https://github.com/phpro/grumphp/blob/master/doc/tasks/phplint.md) and [PhpCs](https://github.com/phpro/grumphp/blob/master/doc/tasks/phpcs.md) are launched at each commit.

> Note: phpro/grumphp is fixed in 0.18.1 version because at the moment I write this doc, the recent version of grumphp is not compatible (has conflit) with some drupal dependencies.
