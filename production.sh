#!/bin/sh

echo "#######################################################"
echo "############            WARNING            ############"
echo "#######################################################"

echo -n "Deploying to production. Continue? [y/N] "

read answer
if [ "$answer" != "y" ]
then
  echo Aborting
  exit 1
fi
git push heroku master && heroku run rake db:migrate -a trailblazer-web && heroku restart -a trailblazer-web
