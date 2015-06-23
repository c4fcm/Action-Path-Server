class LogsController < ApplicationController
  before_action :set_log, only: [:show, :edit, :update, :destroy]

  skip_before_filter :verify_authenticity_token
  def sync
    install_id = params[:install_id]
    status_message = ""
    if install_id==nil
      logger.error "Attempt to log without an install_id!"
      status = 'error'
      status_message = 'attempt to log without and installation id'
    else
      begin
        data = JSON.parse params[:data]
        data.each do |json_log|
        	log = Log.from_json_obj json_log
        	log.save
        end
        status = 'ok'
      rescue JSON::ParserError => e
        status = 'error'
        status_message = 'invalid json in log ('+e.to_s+')'
      end
    end
	  render :json => {"status":status,"message":status_message}
  end
  
  # GET /logs
  # GET /logs.json
  def index
    @logs = Log.all.order(timestamp: :desc)
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
      params.require(:log).permit(:user_id, :issue_id, :action, :timestamp, :lat, :lng, :install_id)
    end
end
