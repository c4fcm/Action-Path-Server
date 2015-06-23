require 'json'

class LogsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def create
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
end
