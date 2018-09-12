require 'test_helper'

class PlayersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @team = teams(:kyoto)
  end

  test "should get new" do
    sign_in_as @team
    get entries_team_path(rank: "C")
    assert_response :success
  end

end
