class PlacesController < ApplicationController
  before_action :set_place, only: [:show, :edit, :update, :destroy]

  def near
    lat = params[:lat]
    lng = params[:lng]
    places_near = SeeClickFix.places_near(lat,lng)['places']
    places_near.select!{|place| place['place_type']==SeeClickFix::PLACE_TYPE_CITY }

    respond_to do |format|
      format.html { render :json => places_near }
      format.json { render :json => places_near }
    end
  end

  # GET /places
  # GET /places.json
  def index
    @places = Place.all
  end

  # GET /places/1
  # GET /places/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_place
      @place = Place.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def place_params
      params.require(:place).permit(:name, :url_name, :state, :issues_fetched_at)
    end
end
