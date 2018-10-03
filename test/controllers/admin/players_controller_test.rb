require 'test_helper'

class Admin::PlayersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_players_index_url
    assert_response :success
  end

end
