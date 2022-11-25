require 'simplecov'
SimpleCov.start

require 'rubygems'
require 'bundler'
Bundler.require :default, :development
require 'httpme/cli'

# require 'mister_bin'
require 'rack/test'
ENV['RACK_ENV'] = 'test'

include HTTPMe

# Bootstrap rack app for rspec
module RSpecMixin
  include Rack::Test::Methods
  def app
    Server
  end
end

RSpec.configure do |c|
  c.include RSpecMixin
end
