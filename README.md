# Trailblazer Web

RVM users:

Update RVM to the latest stable version and install Ruby 2.1.2

    $ rvm get stable
    $ rvm install 2.1.2

You will also need PostgreSQL set up and running on your local machine.
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

    $ rails s

## Contributing

Contributing specific features to this repository should be done through a
feature branch to allow features to be reviewed before being merged.

**Ensure that all features are sufficiently tested, well structured and contain
no superfluous code.**

Be mindful that before being merged, the branch will be squashed to keep the
change history simple.
