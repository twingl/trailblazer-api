workers Integer(ENV['PUMA_WORKERS'] || 3)
threads Integer(ENV['PUMA_MIN_THREADS'] || 8), Integer(ENV['PUMA_MAX_THREADS'] || 12)

preload_app!

rackup      DefaultRackup
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'development'

on_worker_boot do
  # Valid on Rails 4.1+ using the `config/database.yml` method of setting `pool` size
  # https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection
end
