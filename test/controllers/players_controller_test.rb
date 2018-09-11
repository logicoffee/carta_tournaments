require 'test_helper'

class PlayersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_team_player_path
    assert_response :success
  end

end
