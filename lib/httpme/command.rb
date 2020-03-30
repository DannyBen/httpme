require 'mister_bin'
require 'colsole'

module HTTPMe
  class Command < MisterBin::Command
    include Colsole

    summary "Start the web server"
    help "Options can be set using command line arguments or environment variables"

    usage "httpme [PATH] [--port PORT --host HOST --auth AUTH]"
    usage "httpme (-h|--help)"

    param "PATH", "Path to the directory you want to serve [default: .]"
    option "-p, --port PORT", "Server port (default: 3000)"
    option "-o, --host HOST", "Server host (default: 0.0.0.0)"
    option "-a, --auth AUTH", "Specify user:password to enable basic authentication"

    environment 'HTTPME_PATH', "Same as --path"
    environment 'HTTPME_AUTH', "Same as --auth"
    environment 'HTTPME_PORT', "Same as --port"
    environment 'HTTPME_HOST', "Same as --host"

    example "httpme -p 3000"
    example "httpme docs --auth admin:s3cr3t"
    example "HTTPME_AUTH=admin:s3cr3t httpme docs  # same result as above"

    def run
      path = args['PATH'] || ENV['HTTPME_PATH'] || '.'
      port = (args['--port'] || ENV['HTTPME_PORT'] || 3000).to_i
      host = args['--host'] || ENV['HTTPME_HOST'] || '0.0.0.0'
      auth = args['--auth'] || ENV['HTTPME_AUTH']

      raise ArgumentError, "Path not found [#{path}]" unless Dir.exist? path

      server = Server.new path: path, host: host, port: port, auth: auth
      server.run
    end
  end
end
