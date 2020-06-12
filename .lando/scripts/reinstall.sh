#!/usr/bin/env sh

## Re install composer
# Abort if anything fails
set -e

echo "START REINSTALLATION ..."
rm -rf vendor
rm -rf www/core
rm -rf www/modules/contrib
rm -rf www/themes/contrib
composer install
echo "END REINSTALLATION"
