require "kyoto_rank/rank_data"

module KyotoRank
  class Rank
    attr_reader :rank_name, :rank_code, :fee
    
    def initialize(rank_code)
      @rank_name = rank_code.to_s + '級'
      @rank_code = rank_code
      @fee       = RankData.data[rank_code]
    end

    def self.all
      RankData.ranks.map do |rank_code|
        Rank.new(rank_code)
      end
    end

    def self.find(rank_code)
      if RankData.ranks.include?(rank_code)
        Rank.new(rank_code)
      end
    end
  end
end
