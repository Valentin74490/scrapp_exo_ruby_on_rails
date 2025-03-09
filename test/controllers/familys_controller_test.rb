require "test_helper"

class FamilysControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get familys_index_url
    assert_response :success
  end

  test "should get new" do
    get familys_new_url
    assert_response :success
  end

  test "should get create" do
    get familys_create_url
    assert_response :success
  end
end
