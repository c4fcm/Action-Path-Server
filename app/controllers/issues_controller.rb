require 'see_click_fix'

class IssuesController < ApplicationController
  before_action :set_issue, only: [:show, :edit, :update, :destroy]

  skip_before_filter :verify_authenticity_token, :only => [:index,:near]
  skip_before_filter :authenticate_user!, :only => [:index,:near]

  def near 
    @lat = params.require(:lat)
    @lng = params.require(:lng)
    request_type_id = params.require(:request_type)
    @request_type = SeeClickFix.request_type(request_type_id)
    results = SeeClickFix.issues_near(@lat,@lng,request_type_id)
    raw_issues_list = results['issues'].select { |issue| issue['reporter']['role']!=SeeClickFix::ROLE_VERIFIED_OFFICIAL }
    @issues = Issue.insert_or_update_from_json(raw_issues_list, Issue::INVALID_PLACE_ID)
    respond_to do |format|
      format.html { render :near }
      format.json { render json: @issues }
    end
  end

  # GET /places/:place_id/issues
  # GET /places/:place_id/issues.json
  # GET /issues
  # GET /issues.json
  def index
    if params[:place_id] and params[:place_id].to_i>0 then
      place_id = params[:place_id]
      # first make sure the place is in our db locally
      if not Place.exists?(:id => place_id)
        logger.info("Adding new place %d" % place_id)
        place_info = SeeClickFix.place(place_id)
        new_place = Place.from_json place_info
        new_place.prodider = Place::PROVIDER_SEE_CLICK_FIX
        new_place.save
      end
      place = Place.find(place_id)
      if place.provider==Place::PROVIDER_SEE_CLICK_FIX then
        force_update = params[:force_update] and params[:force_update]==1
        if force_update or place.issues_fetched_at.nil? or place.issues_fetched_at < 6.hours.ago
          place.update(issues_fetched_at: DateTime.now)
          # fetch all the latest issues
          raw_issues_list = SeeClickFix.lastest_issues(place.url_name)['issues']
          Issue.insert_or_update_from_json(raw_issues_list, place_id)
          logger.info("Fetched and tried to save #{raw_issues_list.count} new issues from place #{place_id}" )
        end
        if force_update
          flash[:notice] = "Updated issues from SeeClickFix"
        end
      end
      # return results to client
      @issues = Issue.where({:place_id => place_id}).order(created_at: :desc)
    else
      @issues = Issue.all.order(created_at: :desc)
    end
  end

  # GET /issues/1
  # GET /issues/1.json
  def show
  end

  # GET /issues/new
  def new
    @issue = Issue.new
  end

  # GET /issues/1/edit
  def edit
  end

  # POST /issues
  # POST /issues.json
  def create
    @issue = Issue.new(issue_params)

    respond_to do |format|
      if @issue.save
        format.html { redirect_to @issue, notice: 'Issue was successfully created.' }
        format.json { render :show, status: :created, location: @issue }
      else
        format.html { render :new }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /issues/1
  # PATCH/PUT /issues/1.json
  def update
    respond_to do |format|
      if @issue.update(issue_params)
        format.html { redirect_to @issue, notice: 'Issue was successfully updated.' }
        format.json { render :show, status: :ok, location: @issue }
      else
        format.html { render :edit }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /issues/1
  # DELETE /issues/1.json
  def destroy
    @issue.destroy
    respond_to do |format|
      format.html { redirect_to issues_url, notice: 'Issue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_issue
      @issue = Issue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def issue_params
      params.require(:issue).permit(:place_id, :summary, :status, :description, :address, :scf_image_url, :lat, :lng, 
        :geofence_radius, :custom_image, :question, :answer1, :answer2, :answer3, :answer4, :answer5, :answer6 )
    end
end
