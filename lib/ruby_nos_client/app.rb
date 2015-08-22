require 'mini_logger'
require 'active_support/core_ext/class/attribute'

module RubyNosClient
  class App
    include MiniLogger::Loggable

    attr_accessor :agent

    def self.start!
      configure
      run
    end

    def self.configure
      Config.configure_airbrake
      @agent = Config.configure_ruby_nos
    end

    private

    def self.run
      require 'puma/cli'
      Puma::CLI.new(['-p', Config.port.to_s]).run
    end
  end
end

