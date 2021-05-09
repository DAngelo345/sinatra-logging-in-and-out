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
  # username: "skittles123",
  # password: "iluvskittles",

  post '/login' do

    @user = User.find_by(username: params[:username])
    # binding.pry
    # @user = User.find(username)
    # puts "Welcome <%= @user.username %>"
      if @user
        session[:user_id] = @user.id
        redirect to '/account'
      else 
        erb :error
    end
  end

  get '/account' do
    # @user = User.find(session[:user_id])
    # binding.pry
    @user = Helpers.current_user(session)

    if Helpers.is_logged_in?(session)
      Helpers.current_user(session)
      erb :account
    else
      erb :error
    end
  end

  get '/logout' do
    session.clear

    redirect '/'

  end


end

