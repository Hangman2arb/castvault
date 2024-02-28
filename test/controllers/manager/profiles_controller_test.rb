require "test_helper"

class Manager::ProfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get manager_profiles_index_url
    assert_response :success
  end
end
