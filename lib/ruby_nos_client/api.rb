require "grape"
require "grape-swagger"
require "grape-entity"
require "mini_logger"

module RubyNosClient
  class API < Grape::API
    format :json
    include MiniLogger::Loggable

    Config.ruby_nos_agent.rest_api.add_endpoint(path: "/hello", type: "PUB")
    get "/hello" do
      body("Pong")
    end
  end
end

    
