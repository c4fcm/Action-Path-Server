class SubscriptionsController < ApplicationController
  def index
    @subscriptions = Subscription.where(user_id: params[:user_id])
    render :json => @subscriptions
  end
  def destroy
    @subscription = Subscription.find(params[:id])
    @subscription.delete
    head :no_content
  end
end
