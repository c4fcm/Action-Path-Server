class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    if params[:installId].present?
      user = User.get_or_create_from_install_id params[:installId]
      render :json => {:status =>'ok', :msg=> user.id.to_s}
    else
      render :json => {:status =>'error', :msg => 'missing install_id'}
    end
  end
end
