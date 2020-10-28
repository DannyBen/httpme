module HTTPMe
  class IndexRedirector
    def initialize(app, root: '.')
      @app = app
      @root = root
    end

    def call(env)
      path_info = Rack::Utils.unescape env['PATH_INFO']
      path = File.join @root, path_info

      if File.directory?(path) and !path_info.end_with? '/'
        return [302, { 'Location' => "#{env['PATH_INFO']}/" }, []]
      end

      @app.call env
    end
  end
end
