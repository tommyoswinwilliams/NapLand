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
    redirect '/spaces'
  end

  run! if app_file == $0

end