require 'json'

class LogsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def create
    data = JSON.parse params[:data]
	render :json => data
  end
end
