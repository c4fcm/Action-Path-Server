require 'json'

class LogsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def create
    render :json => params 
  end
end
