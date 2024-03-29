require "test_helper"

class Manager::ClientsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get manager_clients_index_url
    assert_response :success
  end

  test "should get new" do
    get manager_clients_new_url
    assert_response :success
  end

  test "should get destroy" do
    get manager_clients_destroy_url
    assert_response :success
  end
end
