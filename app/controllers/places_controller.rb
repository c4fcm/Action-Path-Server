require 'see_click_fix'

class PlacesController < ApplicationController
  before_action :set_place, only: [:show, :edit, :update, :destroy]

  skip_before_filter :verify_authenticity_token, :only => [:near]
  skip_before_filter :authenticate_user!, :only => [:near]

  def near
    lat = params[:lat]
    lng = params[:lng]

    custom_places = Place.where(provider: Place::PROVIDER_CUSTOM)

    scf_place_near = SeeClickFix.places_near(lat,lng)['places']
    scf_place_near.select!{|place| place['place_type']==SeeClickFix::PLACE_TYPE_CITY }

    places_near = custom_places + scf_place_near

    respond_to do |format|
      format.html { render json: places_near }
      format.json { render json: places_near }
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

  # GET /places/new
  def new
    @place = Place.new
  end

  # GET /places/1/edit
  def edit
  end

  # POST /places
  # POST /places.json
  def create
    @place = Place.new(place_params)

    respond_to do |format|
      if @place.save
        format.html { redirect_to @place, notice: 'Place was successfully created.' }
        format.json { render :show, status: :created, location: @place }
      else
        format.html { render :new }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /places/1
  # PATCH/PUT /places/1.json
  def update
    respond_to do |format|
      if @place.update(place_params)
        format.html { redirect_to @place, notice: 'Place was successfully updated.' }
        format.json { render :show, status: :ok, location: @place }
      else
        format.html { render :edit }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /places/1
  # DELETE /places/1.json
  def destroy
    @place.destroy
    respond_to do |format|
      format.html { redirect_to places_url, notice: 'Place was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_place
      @place = Place.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def place_params
      params.require(:place).permit(:name, :url_name, :state, :issues_fetched_at, :json, :provider)
    end
end
