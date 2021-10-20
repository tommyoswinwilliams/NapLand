require "sinatra/base"
require "sinatra/reloader"
require_relative "./lib/space.rb"

class NapLand < Sinatra::Base
  # :nocov
  configure :development do
    register Sinatra::Reloader
  end
  # :nocov

  get "/test" do
    "Welcome to NapLand!"
  end

  get '/spaces' do
    erb :'/spaces/new_space'
  end
  
  post '/spaces' do
    Space.create(name: params[:space_name], description: params[:space_description], price: params[:space_price], available: params[:space_available])
    redirect '/spaces/confirmation'
  end

  get '/spaces/confirmation' do
    erb :'/spaces/confirmation_page'
  end

  get '/spaces/all_listings' do
    @all_spaces = Space.all
    p @all_spaces
    erb :'/spaces/all_listings'
  end

  run! if app_file == $0

end