require 'rack/static'
require "insta_swag"

module RubyNosClient
  HttpServer = Rack::Builder.new do
    use RubyNosClient::ExceptionHandler
    use Airbrake::Rack
    map("/admin/healthcheck") { run RubyNosClient::HealthCheck }
    run Rack::Cascade.new([
        InstaSwag.for(RubyNosClient::API, {prefix: Config.prefix})
        ])
  end
end
