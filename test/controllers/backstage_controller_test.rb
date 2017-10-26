require 'test_helper'

class BackstageControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get backstage_new_url
    assert_response :success
  end

end
