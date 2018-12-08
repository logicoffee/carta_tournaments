require 'csv'

CSV.generate do |csv|
  header = %w[かるた会 氏名]
  csv << header
  @players.each do |player|
    data = [player.team.name, player.full_name]
    csv << data
  end
end
