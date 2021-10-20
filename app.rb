require "sinatra/base"
require "sinatra/reloader"

class NapLand < Sinatra::Base
  # :nocov:
  configure :development do
    register Sinatra::Reloader
  end
  # :nocov:

  enable :sessions

  get "/test" do
    "Welcome to NapLand!"
  end

  get '/' do
    @user = User.find(session[:user_id])
    erb :"index"
  end

  get '/users/new' do
    erb :"users/new"
  end

  post '/users' do
    user = User.create(email: params[:email], password: params[:password])
    session[:user_id] = user.id
    redirect '/'
  end

  get '/sessions/new' do
    erb :"sessions/new"
  end

  post '/sessions' do
    user = User.authenticate(email: params[:email], password: params[:password])
    session[:user_id] = user.id
    redirect('/')
  end

  run! if app_file == $0

end