require 'rack'
require 'rack/handler/puma'
require 'httpme/index_redirector'

module HTTPMe
  class Server
    attr_reader :options

    def initialize(options = {})
      @options = options
    end

    def run
      Rack::Handler::Puma.run(app, **rack_options) do |server|
        # :nocov: - FIXME: Can we test this?
        %i[INT TERM].each do |sig|
          trap(sig) { server.stop }
        end
        # :nocov:
      end
    end

    def app
      path = options[:path] || '.'
      auth = options[:auth]
      zone = options[:zone] || 'Restricted Area'

      Rack::Builder.new do
        if auth
          use Rack::Auth::Basic, zone do |username, password|
            auth.split(':') == [username, password]
          end
        end

        use Rack::Static, urls: ['/'], root: path, cascade: true, index: 'index.html'
        use IndexRedirector, root: path
        run Rack::Directory.new(path)
      end
    end

  private

    def rack_options
      {
        Port: (options[:port] || '3000'),
        Host: (options[:host] || '0.0.0.0'),
      }
    end
  end
end
