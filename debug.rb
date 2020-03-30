action :debug do
  server = HTTPMe::Server.new  
  server.run
end