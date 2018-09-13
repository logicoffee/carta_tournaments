require 'test_helper'

class EntryFlowTest < ActionDispatch::IntegrationTest
  def setup
    @team = teams(:kyoto)
    sign_in_as @team
  end

  test "invalid information" do
    get entries_team_path(rank: "C")
    assert_no_difference 'Player.count' do
      post entries_team_path(rank: "C"), params: { players: [
        { last_name: " ",
          first_name: "あ"*31,
          last_name_kana: "ABC",
          first_name_kana: "漢字"},
        { last_name: "鈴木",
          first_name: "一郎",
          last_name_kana: "すずき",
          first_name_kana: "いちろう"}
      ]}
    end
    assert_template 'players/new'
  end

  test "valid information" do
    get entries_team_path(rank: "C")
    assert_difference 'Player.count', 2 do
      post entries_team_path(rank: "C"), params: { players: [
        { last_name: "田中",
          first_name: "一",
          last_name_kana: "たなか",
          first_name_kana: "はじめ"},
        { last_name: "鈴木",
          first_name: "一郎",
          last_name_kana: "すずき",
          first_name_kana: "いちろう"}
      ]}
    end
    assert_not flash[:success].empty?
    assert_redirected_to team_path
  end
end
