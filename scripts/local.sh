echo "Cleaning cache ..."
drush cr
echo "Importing configurations ..."
drush cim --partial -y
echo "Updating database ..."
drush updatedb -y
echo "Updating translation ..."
drush locale-check -y
drush locale-update -y
echo "Cleaning cache ..."
drush cr
