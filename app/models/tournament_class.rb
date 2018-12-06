class TournamentClass < ApplicationRecord
  belongs_to :tournament
  has_and_belongs_to_many :players, join_table: :tournament_classes_players
end
