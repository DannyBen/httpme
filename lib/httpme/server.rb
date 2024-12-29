require 'rack/contrib/try_static'
require 'sinatra/base'

module HTTPMe
  class Server < Sinatra::Application
    class << self
      def setup(port: 3000, host: '0.0.0.0', path: '.', zone: 'Restricted Area', auth: nil)
        reset!

        set :bind, host
        set :port, port
        set :server, %w[puma webrick]

        # FIXME: Ironically, tests fail without this line
        # ref: https://community.fly.io/t/attack-prevented-by-rack-hostauthorization/22992
        set :environment, :production

        if auth
          use Rack::Auth::Basic, zone do |username, password|
            auth.split(':') == [username, password]
          end
        end

        not_found do
          content_type :text
          '404 Not Found'
        end

        use Rack::TryStatic, root: path, urls: %w[/], try: %w[.html index.html /index.html]

        self
      end
    end
  end
end
