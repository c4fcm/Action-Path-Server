class ResponsesController < ApplicationController
  before_action :set_response, only: [:show, :edit, :update, :destroy]

  skip_before_filter :verify_authenticity_token, :only => [:sync]
  skip_before_filter :authenticate_user!, :only => [:sync, :index]
  after_filter :cors_set_access_control_headers, :only => [:index]

  def sync
    install_id = params[:install_id]
    status_message = ""
    if install_id==nil
      logger.error "Attempt to log without an install_id!"
      status = 'error'
      status_message = 'attempt to sync responses without and installation id'
    else
      begin
        data = JSON.parse params[:data]
        data.each do |json_obj|
          response = Response.from_json_obj json_obj
          response.save
        end
        status = 'ok'
      rescue JSON::ParserError => e
        status = 'error'
        status_message = 'invalid json in response ('+e.to_s+')'
      end
    end
    render :json => {"status"=>status,"message"=>status_message}
  end

  # GET /responses
  # GET /responses.json
  def index
    if params[:issue_id].present?
      @issue = Issue.find_by_id(params[:issue_id])
      @answers = [
        @issue.answer1, 
        @issue.answer2, 
        @issue.answer3, 
        @issue.answer4, 
        @issue.answer5, 
        @issue.answer6,
      ].reject(&:empty?)
      logger.info "ANSWERS"
      logger.info @answers
      @responses = Response.where( issue_id: params[:issue_id])
    elsif params[:install_id].present?
      @responses = Response.where( install_id: params[:install_id])
    else
      @responses = Response.all
    end
  end

  # GET /responses/1
  # GET /responses/1.json
  def show
  end

  # GET /responses/new
  def new
    @response = Response.new
  end

  # GET /responses/1/edit
  def edit
  end

  # POST /responses
  # POST /responses.json
  def create
    @response = Response.new(response_params)

    respond_to do |format|
      if @response.save
        format.html { redirect_to @response, notice: 'Response was successfully created.' }
        format.json { render :show, status: :created, location: @response }
      else
        format.html { render :new }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /responses/1
  # PATCH/PUT /responses/1.json
  def update
    respond_to do |format|
      if @response.update(response_params)
        format.html { redirect_to @response, notice: 'Response was successfully updated.' }
        format.json { render :show, status: :ok, location: @response }
      else
        format.html { render :edit }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /responses/1
  # DELETE /responses/1.json
  def destroy
    @response.destroy
    respond_to do |format|
      format.html { redirect_to responses_url, notice: 'Response was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_response
      @response = Response.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def response_params
      params.require(:response).permit(:user_id, :issue_id, :answer, :timestamp)
    end
end
