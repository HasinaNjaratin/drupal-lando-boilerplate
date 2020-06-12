#!/usr/bin/env sh

## Initialize/reinstall site
# Abort if anything fails
set -e

DRUSH="$(pwd)/vendor/bin/drush -r $(pwd)/www"

#-------------------------- Settings --------------------------------

# Include install config
. ".lando/settings/site_config.sh"
PROJECT_ROOT="."
DOCROOT="www"
SITE_DIRECTORY="default"
DOCROOT_PATH="${PROJECT_ROOT}/${DOCROOT}"
SITEDIR_PATH="${DOCROOT_PATH}/sites/${SITE_DIRECTORY}"

#-------------------------- END: Settings --------------------------------

#-------------------------- Helper functions --------------------------------

# Console colors
red='\033[0;31m'
green='\033[0;32m'
green_bg='\033[1;97;42m'
yellow='\033[1;33m'
NC='\033[0m'

echo_red () { echo -e "${red}$1${NC}"; }
echo_green () { echo -e "${green}$1${NC}"; }
echo_green_bg () { echo -e "${green_bg}$1${NC}"; }
echo_yellow () { echo -e "${yellow}$1${NC}"; }

# Copy a settings file.
# Skips if the destination file already exists.
# @param $1 source file
# @param $2 destination file
copy_settings_file()
{
	source="$1"
	dest="$2"

	if [ ! -f $dest ]; then
		echo "Copying ${dest}..."
		cp $source $dest
	else
		echo "${dest} already in place."
	fi
}

#-------------------------- END: Helper functions --------------------------------

#-------------------------- Functions --------------------------------

composer_install ()
{
	cd "$PROJECT_ROOT"
	echo_green "Installing dependencies..."
	composer install
}

# Initialize local settings files
init_settings ()
{
	rm -f "${SITEDIR_PATH}/settings.php"

	copy_settings_file "${PROJECT_ROOT}/.lando/settings/settings.php" "${SITEDIR_PATH}/settings.php"
	copy_settings_file "${PROJECT_ROOT}/.lando/settings/settings.local.php" "${SITEDIR_PATH}/settings.local.php"
}

# Fix file/folder permissions
fix_permissions ()
{
	echo_green "Making site directory writable..."
	chmod 755 "${SITEDIR_PATH}"
}

# Install site
site_install ()
{
	cd "$DOCROOT_PATH"

	echo_green "Installing Drupal..."
	$DRUSH site-install standard -y \
	  --account-name="$DRUPAL_INSTALL_ADMIN_NAME" \
	  --account-pass="$DRUPAL_INSTALL_ADMIN_PASS" \
	  --account-mail="$DRUPAL_INSTALL_ADMIN_MAIL" \
	  --site-name="$DRUPAL_INSTALL_SITE_NAME"
}

#-------------------------- END: Functions --------------------------------

#-------------------------- Execution --------------------------------

# Project initialization steps
composer_install
fix_permissions
init_settings
site_install

echo_yellow "Admin credential : $DRUPAL_INSTALL_ADMIN_NAME/$DRUPAL_INSTALL_ADMIN_PASS"
echo_green_bg "Congrats! Your Drupal Website is up."

#-------------------------- END: Execution --------------------------------
