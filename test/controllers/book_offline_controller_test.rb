require "test_helper"

class BookOfflineControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get book_offline_index_url
    assert_response :success
  end
end
