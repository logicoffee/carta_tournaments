require 'test_helper'

class TeamSignUpTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "invalid information" do
    assert_no_difference 'Team.count' do
      post sign_up_path, params: {
        team: {
          name: "  ",
          leader: "  ",
          email: "emai.com",
          password: "pass",
          password_confirmation: ""
        }
      }
    end
    assert_select 'div .alert'
  end

  test "valid information" do
    # 正しい内容でかるた会登録
    valid_email = "taro@example.com"
    assert_difference 'Team.count', 1 do
      post sign_up_path, params: {
        team: {
          name: "京都大学かるた会",
          leader: "京大太郎",
          email: valid_email,
          password: "password",
          password_confirmation: "password"
        }
      }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_redirected_to root_url
    assert flash[:info].present?
    assert_not is_signed_in?

    # メール本文中からURLを抽出
    sent_email = ActionMailer::Base.deliveries.last
    #decoded_email = sent_email.body.encoded.split(/\r\n/).map{|i| Base64.decode64 i}.join
    #url_for_activation = /http.*/.match(decoded_email).to_s
    url_for_activation = /http.*/.match(sent_email.body.encoded).to_s

    # アクティベート前はログインできない
    post sign_in_path, params: {
      email: valid_email,
      password: 'password'
    }
    assert_not is_signed_in?

    # 正しいURLからアクティベート
    get url_for_activation
    assert Team.find_by(email: valid_email).activated?
    assert is_signed_in?
    assert_redirected_to team_url
  end
end
