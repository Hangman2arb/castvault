require "test_helper"

class Manager::InstructionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get manager_instructions_index_url
    assert_response :success
  end
end
