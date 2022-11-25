require 'mister_bin'
require 'colsole'
require 'httpme/version'

module HTTPMe
  class Command < MisterBin::Command
    include Colsole

    version HTTPMe::VERSION
    summary 'httpme - static web server with basic authentication'

    help 'Options can be set using command line arguments or environment variables'

    usage 'httpme [PATH] [--port PORT --host HOST --auth AUTH]'
    usage 'httpme (-h|--help|--version)'

    param 'PATH', 'Path to the directory you want to serve [default: .]'
    option '-p --port PORT', 'Server port (default: 3000)'
    option '-o --host HOST', 'Server host (default: 0.0.0.0)'
    option '-a --auth AUTH', 'Specify user:password to enable basic authentication'

    environment 'HTTPME_PATH', 'Same as the PATH argument'
    environment 'HTTPME_AUTH', 'Same as the --auth option'
    environment 'HTTPME_PORT', 'Same as the --port option'
    environment 'HTTPME_HOST', 'Same as the --host option'

    example 'httpme -p 4000'
    example 'httpme docs --auth admin:s3cr3t'
    example 'HTTPME_AUTH=admin:s3cr3t httpme docs  # same result as above'

    def run
      path = args['PATH'] || ENV['HTTPME_PATH'] || '.'
      port = (args['--port'] || ENV['HTTPME_PORT'] || 3000).to_i
      host = args['--host'] || ENV['HTTPME_HOST'] || '0.0.0.0'
      auth = args['--auth'] || ENV['HTTPME_AUTH']

      raise ArgumentError, "Path not found [#{path}]" unless Dir.exist? path

      Server.setup path: path, host: host, port: port, auth: auth
      Server.run!
    end
  end
end
