require 'json'

class LogsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def create
    data = JSON.parse params[:data]
    data.each do |json_log|
    	log = Log.from_json_obj json_log
    	log.save
    end
	render :json => data
  end
end
