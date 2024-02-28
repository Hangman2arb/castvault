require "test_helper"

class Manager::FormsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get manager_forms_index_url
    assert_response :success
  end
end
