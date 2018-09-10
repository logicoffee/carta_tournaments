class TeamMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.team_mailer.account_activation.subject
  #
  def account_activation(team)
    @team = team
    mail to: @team.email, subject: 'アカウントの有効化'
  end
end
