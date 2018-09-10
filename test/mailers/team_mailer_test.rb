require 'test_helper'

class TeamMailerTest < ActionMailer::TestCase
  test "account_activation" do
    team = Team.first
    team.activation_token = SecureRandom.urlsafe_base64

    mail = TeamMailer.account_activation(team)
    assert_equal "アカウントの有効化", mail.subject
    assert_equal [team.email], mail.to
    assert_equal ["from@example.com"], mail.from
    #assert_match team.activation_token, mail.body.encoded
    #assert_match CGI.escape(team.email), mail.body.encoded
    #assert_match team.name, mail.body.encoded
  end

end
