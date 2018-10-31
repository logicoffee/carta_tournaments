# Preview all emails at http://localhost:3000/rails/mailers/admin/member_mailer
class Admin::MemberMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/admin/member_mailer/invitation
  def invitation
    Admin::MemberMailer.invitation
  end

end
