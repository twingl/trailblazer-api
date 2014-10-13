#!/bin/sh

echo -n "Deploying to staging. Continue? [y/N] "

read answer
if [ "$answer" != "y" ]
then
  echo Aborting
  exit 1
fi
git push staging master && heroku run rake db:migrate -a trailblazer-web-staging && heroku restart -a trailblazer-web-staging
