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

  s.required_ruby_version = '>= 3.1'

  s.add_dependency 'colsole', '>= 0.8.1', '< 2'
  s.add_dependency 'mister_bin', '~> 0.7'
  s.add_dependency 'puma', '>= 5.6', '< 7.0'
  s.add_dependency 'rack-contrib', '~> 2.3'
  s.add_dependency 'sinatra', '>= 3.0', '< 5'

  s.metadata['rubygems_mfa_required'] = 'true'
end
