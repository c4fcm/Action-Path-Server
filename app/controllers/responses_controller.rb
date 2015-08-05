class ResponsesController < ApplicationController
  
  def index
  end
  
  skip_before_filter :verify_authenticity_token
  def create
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

end
