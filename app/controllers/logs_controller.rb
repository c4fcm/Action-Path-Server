class LogsController < ApplicationController
  before_action :set_log, only: [:show, :edit, :update, :destroy]

  skip_before_filter :verify_authenticity_token, :only => [:sync]
  skip_before_filter :authenticate_user!, :only => [:sync]

  def stats_by_request_type
    @installs_by_request_type = Install.count_by_request_type
    @stats_by_request_type  = @installs_by_request_type.collect do |request_type,count|
      {
        :installs => Install.with_request_type(request_type),
        :request_type => request_type,
        :count => count,
        :geofences_entered => Log.count_by_action(Log::ACTION_ENTERED_GEOFENCE,request_type),
        :geofence_notifications_clicked => Log.count_by_action(Log::ACTION_CLICKED_ON_SURVEY_NOTIFICATION,request_type),
        :responses => Response.count_for_request_type(request_type),
        :responses_logs => Log.count_by_action(Log::ACTION_RESPONDED_TO_QUESTION,request_type),
        :responses_from_notification => Log.count_by_action(Log::ACTION_RESPONDED_TO_QUESTION_FROM_GEOFENCE_NOTIFICATION,request_type)
      }
    end
    @geofences_entered = Log.count_by_action(Log::ACTION_ENTERED_GEOFENCE)
    @geofence_notifications_clicked = Log.count_by_action(Log::ACTION_CLICKED_ON_SURVEY_NOTIFICATION)
    @clicks_by_menu_item = Log.count_by_action(Log::ALL_MENU_ACTIONS)
    @total_menu_item_clicks = @clicks_by_menu_item.inject(0){|sum, item| sum + item[:clicks]}
    @issue_updated_notifications = Log.count_by_action(Log::ACTION_ISSUE_STATUS_UPDATED)
    @issue_updated_clicks = Log.count_by_action(Log::ACTION_CLICKED_ON_UPDATE_NOTIFICATION)
  end
  
  def sync
    install_id = params[:install_id]
    status_message = ""
    if install_id==nil
      logger.error "Attempt to log without an install_id!"
      status = 'error'
      status_message = 'attempt to sync logs without and installation id'
    else
      begin
        data = JSON.parse params[:data]
        data.each do |json_obj|
        	log = Log.from_json_obj json_obj
        	log.save
        end
        status = 'ok'
      rescue JSON::ParserError => e
        status = 'error'
        status_message = 'invalid json in log ('+e.to_s+')'
      end
    end
	  render :json => {"status"=>status,"message"=>status_message}
  end
  
  # GET /logs
  # GET /logs.json
  def index
    if params[:issue_id].present?
      @logs = Log.where( issue_id: params[:issue_id]).order(timestamp: :desc).page(params[:page]).per(500)
    elsif params[:install_id].present? and params[:action_text].present?
      @logs = Log.where( install_id: params[:install_id]).
        where( action: params[:action_text]).order(timestamp: :desc).page(params[:page]).per(500)
    elsif params[:install_id].present?
      @logs = Log.where( install_id: params[:install_id]).order(timestamp: :desc).page(params[:page]).per(500)
    elsif params[:request_type].present?
      @logs = Log.where( details: params[:request_type]).order(timestamp: :desc).page(params[:page]).per(500)
    else
      @logs = Log.all.order(timestamp: :desc).page(params[:page]).per(500)
    end
  end

  # GET /logs/1
  # GET /logs/1.json
  def show
  end

  # GET /logs/new
  def new
    @log = Log.new
  end

  # GET /logs/1/edit
  def edit
  end

  # POST /logs
  # POST /logs.json
  def create
    @log = Log.new(log_params)

    respond_to do |format|
      if @log.save
        format.html { redirect_to @log, notice: 'Log was successfully created.' }
        format.json { render :show, status: :created, location: @log }
      else
        format.html { render :new }
        format.json { render json: @log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /logs/1
  # PATCH/PUT /logs/1.json
  def update
    respond_to do |format|
      if @log.update(log_params)
        format.html { redirect_to @log, notice: 'Log was successfully updated.' }
        format.json { render :show, status: :ok, location: @log }
      else
        format.html { render :edit }
        format.json { render json: @log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /logs/1
  # DELETE /logs/1.json
  def destroy
    @log.destroy
    respond_to do |format|
      format.html { redirect_to logs_url, notice: 'Log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_log
      @log = Log.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def log_params
      params.require(:log).permit(:user_id, :issue_id, :action, :details, :timestamp, :lat, :lng, :install_id)
    end
end
