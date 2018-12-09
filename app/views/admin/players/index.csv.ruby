require 'csv'

CSV.generate do |csv|
  header = %w[出場級 かるた会 氏名]
  csv << header
  @tournament_classes.each do |t_class|
    t_class.players.each do |player|
      data = [t_class.name, player.team.name, player.full_name]
      csv << data
    end
  end
end
