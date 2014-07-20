if ENV["REDISCLOUD_URL"]
  Resque.redis = ENV["REDISCLOUD_URL"]
end
