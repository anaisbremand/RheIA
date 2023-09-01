require "test_helper"

class ProgrammationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get programmations_index_url
    assert_response :success
  end

  test "should get show" do
    get programmations_show_url
    assert_response :success
  end

  test "should get new" do
    get programmations_new_url
    assert_response :success
  end

  test "should get create" do
    get programmations_create_url
    assert_response :success
  end

  test "should get update" do
    get programmations_update_url
    assert_response :success
  end

  test "should get edit" do
    get programmations_edit_url
    assert_response :success
  end

  test "should get destroy" do
    get programmations_destroy_url
    assert_response :success
  end
end
