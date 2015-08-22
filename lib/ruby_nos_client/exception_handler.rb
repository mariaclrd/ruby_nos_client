require 'mini_logger'
require 'airbrake'

module RubyNosClient

  class ExceptionHandler

    include MiniLogger::Loggable

    def initialize(app)
      @app = app
    end

    def internal_error_message
      'Internal server error'
    end

    def call(env)
      @env = env
      begin
        @app.call(@env)
      rescue StandardError => e
        say :warn, 'Notyfing an error to airbrake'
        notification = Airbrake.notify(e, error_message: e.message.to_s)
        say :warn, "Airbrake notified #{notification.inspect}, #{e.message}, #{e.backtrace}"
        Rack::Response.new([internal_error_message], 500, { "Content-type" => "text/error"})
      end
    end
  end
end