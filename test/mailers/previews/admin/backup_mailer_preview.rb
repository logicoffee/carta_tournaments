# Preview all emails at http://localhost:3000/rails/mailers/admin/backup_mailer
class Admin::BackupMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/admin/backup_mailer/backup_email
  def backup_email
    Admin::BackupMailer.backup_email
  end

end
