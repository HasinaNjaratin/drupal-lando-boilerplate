#!/usr/bin/env sh

## Update local environment
# Abort if anything fails
set -e

echo "START LOCAL SYNCHRONOZATION ..."
composer install
echo "Cleaning cache ..."
drush cr
echo "Importing configurations ..."
drush cim --partial -y
echo "Updating database ..."
drush updatedb -y
echo "Updating translation ..."
drush pm-enable locale -y
drush locale-check -y
drush locale-update -y
echo "Cleaning cache ..."
drush cr
echo "END LOCAL SYNCHRONOZATION"
