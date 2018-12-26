require 'csv'

class Tournament < ApplicationRecord
  has_many :invitations
  has_many :admins
  has_many :tournament_classes

  def players_csv
    t_classes_with_players = TournamentClass
                               .includes(players: [:team])
                               .where(
                                 tournament_id: id,
                                 players: { deleted: false }
                               )
    CSV.generate(encoding: 'Shift_JIS') do |csv|
      csv << [
        "かるた会",
        "氏",
        "名",
        "氏(ふりがな)",
        "名(ふりがな)",
        "段位",
        "出場級",
        "学校名",
        "学年"
      ]
      t_classes_with_players.each do |t_class|
        t_class.players.each do |player|
          csv << [
            player.team.name,
            player.last_name,
            player.first_name,
            player.last_name_kana,
            player.first_name_kana,
            player.rank,
            t_class.name,
            player.parsed_extra_attributes['school_name'],
            player.parsed_extra_attributes['school_year']
          ]
        end
      end
    end
  end

  def admin_emails
    admins.map(&:email)
  end
end
