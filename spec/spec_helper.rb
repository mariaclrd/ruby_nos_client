require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rack/test'
require 'rspec'
require 'pry'
require 'yaml'

$LOAD_PATH << File.join(File.dirname(__FILE__),'..')
require 'config/environment'

include Rack::Test::Methods
include RubyNosClient

RSpec.configure do |config|
   config.color = true
   config.tty = true
end

