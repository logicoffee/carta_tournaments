require 'test_helper'

class TeamSignUpTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
  end

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
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_redirected_to root_url
    assert_not flash[:info].empty?
    assert_not is_signed_in?

    team = assigns(:team)
    assert_not team.activation_token.nil?
    post sign_in_path, params: {
      email: team.email,
      password: 'password'
    }
    assert_not is_signed_in?

    get account_activation_path('invalidtoken', email: team.email)
    assert_not is_signed_in?

    get account_activation_path(team.activation_token, email: 'invalid@example.com')
    assert_not is_signed_in?

    get account_activation_path(team.activation_token, email: team.email)
    assert team.reload.activated?
    assert is_signed_in?
    assert_redirected_to team_url
    follow_redirect!
    assert_template 'teams/show'
  end
end
