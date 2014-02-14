class PlacesController < ApplicationController
  def index
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    session[:last_city] = params[:city]
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end
  def show

    if session(:last_city).nil?
      redirect_to places_path
    else
      @places = BeermappingApi.places_in(session[:last_city])
      #byebug
      @place = @places.find(__id__)
      #byebug
      render :show
    end
  end
end