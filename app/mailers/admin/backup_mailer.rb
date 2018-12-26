class Admin::BackupMailer < ApplicationMailer

  def backup_email(tournament)
    attachments['players.csv'] = tournament.players_csv
    mail to: tournament.admin_emails, subject: "参加者一覧バックアップ"
  end
end
