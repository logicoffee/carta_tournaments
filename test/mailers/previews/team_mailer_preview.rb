# Preview all emails at http://localhost:3000/rails/mailers/team_mailer
class TeamMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/team_mailer/account_activation
  def account_activation
    team = Team.first
    team.activation_token = SecureRandom.urlsafe_base64
    TeamMailer.account_activation(team)
  end

end
