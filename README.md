# Trailblazer Web

[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.svg)](https://dashboard.heroku.com/new?template=https://github.com/twingl/trailblazer-api/tree/master)

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

**Note: This docker configuration is new and suggestions/improvements are
welcomed**


### Not Docker

RVM users:

Update RVM to the latest stable version and install Ruby 2.3.x

    $ rvm get stable
    $ rvm install 2.3.x

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

Install the required gems:

    $ bundle install

And start the development server

    $ bundle exec foreman start
