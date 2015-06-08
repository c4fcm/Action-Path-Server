class ResponsesController < ApplicationController
  def index
    @subscriptions = Subscription.where(user_id: params[:user_id])
    render :json => @subscriptions
  end
  def create
    render :json => params 
  end
end
