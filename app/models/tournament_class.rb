class TournamentClass < ApplicationRecord
  belongs_to :tournament
  has_and_belongs_to_many :players, join_table: :tournament_classes_players

  scope :find_by_tournament_class_id, -> (id) {
    where(id: id) unless id.nil?
  }
end
