require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get create" do
    get :create
    assert_redirected_to user_path(assigns(:user))
  end

end
