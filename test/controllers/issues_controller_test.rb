require 'test_helper'

class IssuesControllerTest < ActionController::TestCase
  test "should get issues" do
    get :index
    assert_response :success
  end
  test "should get issue" do
    get :show, {:id => issues(:pothole).id}
  end
end
