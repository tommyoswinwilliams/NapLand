require "sinatra/base"
require "sinatra/reloader"
require "sinatra/flash"
require_relative "./lib/space.rb"
require_relative './lib/user'

class NapLand < Sinatra::Base
  # :nocov:
  configure :development do
    register Sinatra::Reloader
  end
  # :nocov:

  enable :sessions
  register Sinatra::Flash

  get "/test" do
    "Welcome to NapLand!"
  end

  get '/spaces/new' do
    erb :'/spaces/new_space'
  end

  post '/spaces' do
    Space.create(name: params[:space_name], description: params[:space_description], price: params[:space_price], available_from: params[:space_available_from], available_to: params[:space_available_to])
    redirect '/spaces/confirmation'
  end

  get '/spaces/confirmation' do
    erb :'/spaces/confirmation_page'
  end

  get '/spaces' do
    @all_spaces = Space.all
    @user = User.find(session[:user_id])
    erb :'/spaces/all_listings'
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
    redirect '/spaces'
  end

  get '/sessions/new' do
    erb :"sessions/new"
  end

  post '/sessions' do
    user = User.authenticate(email: params[:email], password: params[:password])
    if user
      session[:user_id] = user.id
      redirect('/spaces')
    else
      flash[:notice] = 'Please check your email or password'
      redirect('/sessions/new')
    end
  end

  post '/sessions/destroy' do
    session.clear
    flash[:notice] = 'You have signed out.'
    redirect('/')
  end

  get 'spaces/:id' do
    # @space_id = params[:id]
    @space = Space.find(id: params[:id])
    erb :'spaces/listing'
  end
  
  post '/requests' do
    flash[:notice] = 'Your request has been made.'
    redirect('/spaces')
  end

  run! if app_file == $0

end