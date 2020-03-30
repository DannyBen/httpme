require 'httpme/command'

module HTTPMe
  class CLI
    def self.router
      MisterBin::Runner.new version: VERSION, handler: Command
    end
  end
end
