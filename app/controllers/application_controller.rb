require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
     if @user != nil && @user.password == params[:password]
      #  binding.pry
     session[:user_id] = @user.id
     redirect to '/account'
   end
     erb :error
  end


  get '/account' do
    if session[:user_id] = @user.id
      binding.pry
    erb :account
  end
  #  <!-- if # session[:user_id] exists
     # show account page
  #  else
     # show error -->
  end

  get '/logout' do
    session.clear
    redirect to '/'
  end


end
