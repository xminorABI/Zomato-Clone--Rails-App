require "test_helper"

class HomePageControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get home_page_new_url
    assert_response :success
  end
end
