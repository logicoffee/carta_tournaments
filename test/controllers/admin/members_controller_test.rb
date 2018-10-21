require 'test_helper'

class Admin::MembersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admin_members_new_url
    assert_response :success
  end

end
