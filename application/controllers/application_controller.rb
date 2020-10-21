require './config/environment'

class ApplicationController < Sinatra::Base

    configure do
        enable :sessions
        set :session_secret, 'password_security'
        set :public_folder, 'public'
        set :views, 'application/views' 

    end
  
    get '/' do
        erb :index
    end


#### Helper Methods

    helpers do
 
        def logged_in?
            !!current_user
        end

        def current_user
            if session[:user_id]
                User.find_by(id: session[:user_id])
            end
        end

    end

####-----------------


end