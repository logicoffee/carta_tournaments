require 'test_helper'

class EntryFlowTest < ActionDispatch::IntegrationTest
  def setup
    @tournament = tournaments(:shiga)
    @tournament_class = @tournament.tournament_classes.first
    @team = teams(:kyoto)
    sign_in_as @team
  end

  test "invalid information" do
    get entries_team_path(tournament_id: @tournament.id)
    assert_no_difference 'Player.count' do
      post entries_team_path(tournament_id: @tournament.id), params: {
        tournament_class_id: 100,
        player: {
            last_name: " ",
            first_name: "あ"*31,
            last_name_kana: "ABC",
            first_name_kana: "漢字",
            rank: 20,
            extra_attributes: []
        }
      }
    end
    assert_select 'div .alert'
  end

  test "valid information" do
    get entries_team_path(tournament_id: @tournament.id)
    assert_difference [ 'Player.count', '@tournament_class.players.count' ], 1 do
      post entries_team_path(tournament_id: @tournament.id), params: {
        tournament_class_id: @tournament_class.id,
        player: {
            last_name: "鈴木",
            first_name: "一郎",
            last_name_kana: "すずき",
            first_name_kana: "いちろう",
            rank: 2,
            extra_attributes: '{}'
        }
      }
    end
    assert flash[:success].present?
    assert_redirected_to team_url
  end
end
