Gaffe.configure do |config|
  config.errors_controller = {
    %r[^/api/v1/] => 'Api::V1::ErrorsController',
    %r[^/] => 'ErrorsController'
  }
end

Gaffe.enable!
