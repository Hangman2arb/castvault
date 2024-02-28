require "test_helper"

class Manager::SettingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get manager_settings_index_url
    assert_response :success
  end
end
