require 'csv'

namespace :backup do
  desc "email with players csv file"
  task email_csv: :environment do
    Tournament.all.each do |tournament|
      Admin::BackupMailer.backup_email(tournament).deliver
    end
  end
end
