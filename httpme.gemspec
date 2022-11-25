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
  s.required_ruby_version = '>= 2.6.0'

  s.add_runtime_dependency 'colsole', '~> 0.7'
  s.add_runtime_dependency 'mister_bin', '~> 0.7'
  s.add_runtime_dependency 'puma', '>= 5.1'
  # rack 3 is breaking tests, so we keep 2.x for now
  #   ref: https://github.com/rack/rack/discussions/1977
  #   ideally, we want this:
  #   s.add_runtime_dependency 'rack', '>= 2.2', '< 4'
  s.add_runtime_dependency 'rack', '~> 2.2'

  s.metadata['rubygems_mfa_required'] = 'true'
end
