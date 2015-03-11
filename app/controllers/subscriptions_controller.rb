class SubscriptionsController < ApplicationController
  def destroy
    @subscription = Subscription.find(params[:id])
    @subscription.delete
    head :no_content
  end
end
