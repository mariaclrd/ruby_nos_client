require 'yaml'
require 'mini_logger'
require 'ruby_nos'
require 'open-uri'
require 'pry'

module RubyNosClient
  class Config

    include MiniLogger::Loggable
    class << self
      def port
        server_info ||= load_file('server')
        server_info["port"]
      end

      def host
        server_info ||= load_file('server')
        @host ||= (server_info["host"] || my_machine_ip || request_for_public_api)
      end

      def prefix
        prefix = load_file('api')
        prefix['prefix']
      end

      def configure_airbrake
        require "airbrake"
        api_key = load_file('airbrake')
        Airbrake.configure do |c|
          c.api_key = api_key['api_key']
          c.logger = logger
        end
      end

      def configure_ruby_nos
        config = load_file('ruby_nos')
        RubyNos.configure do |c|
          c.cloud_uuid = config['cloud']
          c.port = config['port']
          c.group_address = config['group_address']
          c.time_between_messages = config['time_between_messages']
        end
        configure_ruby_nos_api
        ruby_nos_agent.start!
        ruby_nos_agent
      end

      def ruby_nos_agent
        @ruby_nos_agent ||= RubyNos::Agent.new
      end

      def configure_ruby_nos_api
        config= load_file('ruby_nos')
        ruby_nos_agent.rest_api.name = config["api_name"]
        ruby_nos_agent.rest_api.port = port
        ruby_nos_agent.rest_api.host = host
      end

      private

      def load_file environment
        @config ||= YAML.load(File.read('config/application-sample.yml'))
        @config[environment]
      end

      def request_for_public_api
        remote_ip = open('http://checkip.amazonaws.com').read
        remote_ip.gsub("\n", '') if remote_ip
      end

      def my_machine_ip
        @ip ||= calculate_my_machine_ip
      end

      def calculate_my_machine_ip
        socket = UDPSocket.open
        socket.connect("64.233.187.99", 1)
        ip = socket.addr.last
        socket.close
        ip
      end
    end
  end
end