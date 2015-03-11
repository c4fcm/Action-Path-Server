require 'test_helper'

class SubscriptionsControllerTest < ActionController::TestCase
  test "should index" do
    get :index, {:user_id => users(:one).id}
    assert_response :success
  end
  test "should delete" do
    assert_difference('Subscription.count', -1) do
      delete :destroy, {:id => subscriptions(:one_pothole).id}
    end
    assert_response :no_content
  end
end
