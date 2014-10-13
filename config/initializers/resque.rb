if ENV["REDISCLOUD_URL"]
  Resque.redis = ENV["REDISCLOUD_URL"]
end

Resque.before_fork do
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

Resque.after_fork do
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
