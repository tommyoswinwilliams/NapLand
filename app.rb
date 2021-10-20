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
    if ENV['ENVIRONMENT'] == "test"
      connection = PG.connect(dbname: 'napland_test')
    else
      connection = PG.connect(dbname: 'napland')
    end

    result = connection.exec_params("SELECT * FROM users WHERE email = $1", [params[:email]])
    user = User.new(result[0]['id'], result[0]['email'], result[0]['password'])

    session[:user_id] = user.id
    redirect('/')
  end

  run! if app_file == $0

end