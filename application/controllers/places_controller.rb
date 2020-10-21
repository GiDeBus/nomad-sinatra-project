require 'rack-flash'

class PlacesController < ApplicationController
    use Rack::Flash

    get '/places' do
        if logged_in?
            @places = Place.all
            erb :'/places/places'
        else
            redirect to '/login'
        end
    end

    get '/places/new' do
        if logged_in?
            erb :'/places/new'
        else
            redirect to '/login'
        end
    end

    post '/places' do
        if params[:name].blank?
            redirect to "/places/new"
        else
            @place = current_user.places.create(name: params[:name])
            redirect to "/places/#{@place.id}"
        end
    end

    get '/places/:id' do
       if logged_in?
            @place = Place.find_by_id(params[:id])
            erb :'/places/show'
       else
            redirect to '/login'
       end
    end

    get '/places/:id/edit' do
        if logged_in?
          @place = Place.find_by_id(params[:id])
            if @place && @place.user_id == current_user.id
              erb :'/places/edit'
            else
              redirect '/places'
            end
        else
          redirect to '/login'
        end
    end

    patch '/places/:id' do

        if params[:name].blank?
            redirect to "/places/#{params[:id]}/edit"
        else
            @place = Place.find_by_id(params[:id])
            if @place && @place.user == current_user
                if @place.update(name:params[:name])
                    redirect to "/places/#{@place.id}"
                else
                    redirect to "/places/#{@place.id}/edit"
                end
            end
        end    
    end

    delete '/places/:id/delete' do
        if logged_in?
            @place = Place.find_by_id(params[:id])
            if @place && @place.user_id == current_user.id
                @place.destroy
                redirect to "/places"
            else
                flash[:message] = "You do not have rights to delete this place."
                redirect to "/places"
            end
        else
            redirect '/login'
        end
    end

end