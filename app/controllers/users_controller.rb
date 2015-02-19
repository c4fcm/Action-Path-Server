class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    @user = User.new
    @user.save
    redirect_to @user
  end
  def show
    @user = User.find(params[:id])
    render :json => @user.to_json
  end
end
