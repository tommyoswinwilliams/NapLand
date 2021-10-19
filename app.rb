require "sinatra/base"
require "sinatra/reloader"

class NapLand < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get "/test" do
    "Welcome to NapLand!"
  end

  get '/' do
    "Welcome to NapLand!"
  end

  get '/users/new' do
    erb :"users/new"
  end

  post '/users' do
    User.create(email: params[:email], password: params[:password])
    redirect '/'
  end

  run! if app_file == $0

end