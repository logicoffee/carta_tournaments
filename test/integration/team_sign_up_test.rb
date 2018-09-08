require 'test_helper'

class TeamSignUpTest < ActionDispatch::IntegrationTest
  test "invalid information" do
    assert_no_difference 'Team.count' do
      post sign_up_path, params: { team: {
        name: "  ",
        leader: "  ",
        email: "emai.com",
        password: "pass",
        password_confirmation: ""
      }}
    end
    assert_template 'teams/new'
  end

  test "valid information" do
    assert_difference 'Team.count', 1 do
      post sign_up_path, params: { team: {
        name: "京都大学かるた会",
        leader: "京大太郎",
        email: "taro@example.com",
        password: "password",
        password_confirmation: "password"
      }}
    end
    assert_redirected_to team_url
    follow_redirect!
    assert_not flash.empty?
  end
end
