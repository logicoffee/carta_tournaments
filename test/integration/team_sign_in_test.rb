require 'test_helper'

class TeamSignInTest < ActionDispatch::IntegrationTest
  test "invalid information" do
    get sign_in_path
    post sign_in_path, params: {
      email: "abcdefg@hijk.lmn",
      password: "wordpass"
    }
    assert_not flash[:danger].empty?
    assert_template 'sessions/new'
  end

  test "valid information" do
    kyoto = teams(:kyoto)
    get sign_in_path
    post sign_in_path, params: {
      email: kyoto.email,
      password: "password"
    }
    assert_redirected_to team_path
    follow_redirect!
    assert_template 'teams/show'
  end
end
