require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should create user" do
    assert_difference('User.count') do
      post :create
    end
    assert_redirected_to user_path(assigns(:user))
  end
  test "sould get user" do
    get :show, {:id => users(:one).id}
    assert_response :success
  end
end
