module KyotoRank
  module RankData
    @data = {
      C: 2000,
      D: 1800,
      E: 1200
    }

    def self.data
      @data
    end

    def self.ranks
      @data.keys
    end
  end
end
