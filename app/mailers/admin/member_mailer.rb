class Admin::MemberMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.admin.member_mailer.invitation.subject
  #
  def invitation_email(invitation)
    @invitation = invitation
    mail to: @invitation.email, subject: "管理者の招待"
  end
end
