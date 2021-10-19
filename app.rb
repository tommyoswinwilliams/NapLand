require "sinatra/base"
require "sinatra/reloader"

class NapLand < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get "/test" do
    "Welcome to NapLand!"
  end

  run! if app_file == $0

end