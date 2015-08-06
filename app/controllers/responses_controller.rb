class ResponsesController < ApplicationController
  before_action :set_response, only: [:show, :edit, :update, :destroy]

  skip_before_filter :verify_authenticity_token
  def add
    if params[:installId].present? and params[:issueId].present? and params[:answer].present? 
      user = User.find_by_install_id params[:installId]
      if user.nil?
        logger.error "tried to create an answer for user that doesn't exist (install_id #{params[:installId]})"
        render :json => {:status => 'error', :msg => 'invalid install_id'}
      else
        response = Response.new
        response.user_id = user.id
        response.issue_id = params[:issueId].to_i
        response.answer = params[:answer]
        response.save
        render :json => {:status =>'ok'}
      end
    else
      logger.warn "got a call to respond without the right params"
      render :json => {:status =>'error',:msg => 'missing params'}
    end
  end

  # GET /responses
  # GET /responses.json
  def index
    @responses = Response.all
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
