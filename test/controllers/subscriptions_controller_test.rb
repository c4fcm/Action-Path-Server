require 'test_helper'

class SubscriptionsControllerTest < ActionController::TestCase
  test "should delete" do
    assert_difference('Subscription.count') do
      delete :destroy, {:id => subscriptions(:one_pothole).id}
    end
    assert_response :no_content
  end
end
