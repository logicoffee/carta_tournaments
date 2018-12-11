require 'csv'

CSV.generate do |csv|
  header = %w[出場級 かるた会 氏 名 氏(ふりがな) 名(ふりがな) 段位 学校名 学年]
  csv << header
  @tournament_classes.each do |t_class|
    t_class.players.each do |player|
      school_info = JSON.parse(player.extra_attributes)
      data = [
        t_class.name,
        player.team.name,
        player.last_name,
        player.first_name,
        player.last_name_kana,
        player.first_name_kana,
        player.rank,
        school_info["school_name"],
        school_info["school_year"]
      ]
      csv << data
    end
  end
end
