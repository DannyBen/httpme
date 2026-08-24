lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'httpme/version'

Gem::Specification.new do |s|
  s.name        = 'httpme'
  s.version     = HTTPMe::VERSION
  s.summary     = 'Static files web server with basic authentication'
  s.description = 'Command line utility for running a web server for static files with basic authentication support'
  s.authors     = ['Danny Ben Shitrit']
  s.email       = 'db@dannyben.com'
  s.files       = Dir['README.md', 'lib/**/*.*']
  s.executables = ['httpme']
  s.homepage    = 'https://github.com/dannyben/httpme'
  s.license     = 'MIT'

  s.required_ruby_version = '>= 3.2'

  s.add_dependency 'colsole', '~> 1.0'
  s.add_dependency 'mister_bin', '~> 0.7'
  s.add_dependency 'puma', '~> 8.0'
  s.add_dependency 'rack-contrib', '~> 2.3'
  s.add_dependency 'rackup', '~> 2.2'
  s.add_dependency 'sinatra', '~> 4.2'

  s.metadata['rubygems_mfa_required'] = 'true'
end
