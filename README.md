# Trailblazer Web

## Links

- [Pivotal Tracker](https://www.pivotaltracker.com/n/projects/1140072)
- [Heroku Staging](https://dashboard.heroku.com/apps/trailblazer-web-staging)
- [Heroku Production](https://dashboard.heroku.com/apps/trailblazer-web)

## Documentation

- [Authentication](http://docs.trailblazerauthentication.apiary.io/)
- [API v1](http://docs.trailblazerapiv1.apiary.io/)

## Process

Stories are taken from [Pivotal
Tracker](https://www.pivotaltracker.com/n/projects/1140072).
A story is considered finished when the changes exist in a feature branch on
GitHub. These changes should then be reviewed, merged into master and pushed to
the [staging app](http://staging.trailblazer.io/) at which point they are
considered delivered and ready for acceptance testing. Depending on whether
they are accepted or not, they can then be marked as such in Pivotal and
deployed to [production](https://app.trailblazer.io/).

## Setup

### Docker (Compose)

[Set up your system so you can use docker-compose](https://docs.docker.com/compose/install/)

Then bootstrap the application (this will create a container each for the API
and for the postgresql database)

    $ docker-compose build
    # Go make a coffee or something...
    $ docker-compose run web bundle exec rake db:schema:load
    $ docker-compose up

Now, all going well, you should have a copy of the API running locally.

You need to run regular bundle/rake/rails commands inside the container, e.g.

    $ docker-compose run web bundle install
    $ docker-compose run web bundle exec <command>


### Not Docker

RVM users:

Update RVM to the latest stable version and install Ruby 2.2.1

    $ rvm get stable
    $ rvm install 2.2.1

You will also need PostgreSQL and Redis set up and running on your local
machine, as well as access to a Google Apps domain with
administrative privileges.

PostgreSQL provide
[guides](http://wiki.postgresql.org/wiki/Detailed_installation_guides) to help
you get started.

> The app will need permissions to create databases for `rake db:create:all` to
> function)

This guide will assume you have cloned the repository into a folder called
**trailblazer-web**

If you're using RVM, provision a gemset:

    $ echo 'trailblazer-web' > .ruby-gemset && cd .
    ### Confirm that you trust this gemset

Install the required gems:

    $ bundle install

And start the development server

    $ foreman start

## Polymer Notes

If you plan to work on any of the Polymer components in the application, you'll
need to use [vulcanize](https://github.com/polymer/vulcanize).

This is because of a [shortcoming](https://github.com/ahuth/emcee/issues/11)
with a support library [emcee](https://github.com/ahuth/emcee) intended to
integrate Polymer nicely with the Rails asset pipeline, and will hopefully be
resolved in the near future.

Make sure you have NPM installed and run `npm install` and it will install
vulcanize.

There is a rake task `rake vulcanize` which will run vulcanize over `tb-app`
and output `public/vulcanized.html`.

There's also a Guardfile set up to act as a live reload server, and vulcanize
the assets as well. Run `guard livereload` as you're working on the app and it
will automatically vulcanize `tb-app`.
