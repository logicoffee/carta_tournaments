require 'test_helper'

class EntryFlowTest < ActionDispatch::IntegrationTest
  def setup
    @tournament = tournaments(:shiga)
    @tournament_class = @tournament.tournament_classes.first
    @team = teams(:kyoto)
    sign_in_as @team

    last_name = "鈴木"
    first_name = "一郎"
    @full_name = last_name + ' ' + first_name

    @valid_player_params = {
      last_name: last_name,
      first_name: first_name,
      last_name_kana: "すずき",
      first_name_kana: "いちろう",
      rank: 2,
      extra_attributes: {
        school_name: "かるた中学校",
        school_year: 2
      }
    }
  end

  test "exception for invalid tournament id" do
    assert_raises do
      get entries_team_path(tournament_id: 100)
    end

    assert_raises do
      post entries_team_path(tournament_id: 100), params: {
        tournament_class_id: @tournament_class.id,
        player: @valid_player_params
      }
    end
  end

  test "exception for invalid tournament class id" do
    assert_raises do
      post entries_team_path(tournament_id: @tournament.id), params: {
        tournament_class_id: 100,
        player: @valid_player_params
      }
    end
  end

  test "invalid information" do
    get entries_team_path(tournament_id: @tournament.id)
    assert_no_difference 'Player.count' do
      post entries_team_path(tournament_id: @tournament.id), params: {
        # Playerモデルのバリデーションをチェックするため, tournament_class_idは正しいものを設定
        tournament_class_id: @tournament_class.id,
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
        player: @valid_player_params
      }
    end
    assert flash[:success].present?
    assert_redirected_to team_url

    follow_redirect!
    assert_select 'td', text: @full_name
  end

  test "update player" do
    player = Player.first
    get edit_entries_team_path(player)
    put update_entries_team_path(player), params: { player: @valid_player_params }
    assert_redirected_to team_url
  end
end
