require 'test_helper'

class Admin::InvitationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admin_invitations_new_url
    assert_response :success
  end

end
