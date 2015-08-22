require 'thor'
require_relative '../../config/environment'

module RubyNosClient
  class Cli < Thor
    desc 'test', 'run the rspec tests'
    def test
      require_relative '../../spec/spec_helper'
      RSpec::Core::Runner.run(['spec'])
    end

    desc 'start', 'runs the app itself'
    def start
      RubyNosClient::App.start!
    end

    desc 'console', 'binding.pry for the masses'
    def console
      require 'pry'
      binding.pry
    end
  end
end
