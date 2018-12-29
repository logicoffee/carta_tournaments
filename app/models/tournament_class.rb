class TournamentClass < ApplicationRecord
  belongs_to :tournament
  has_and_belongs_to_many :players,
                          -> { where(deleted: false) },
                          join_table: :tournament_classes_players

  scope :find_and_order_by_id, -> (tournament_id:, tournament_class_id: nil) {
    base_query = where(tournament_id: tournament_id)

    if tournament_class_id.nil?
      base_query.order(:id)
    else
      base_query.where(id: tournament_class_id)
    end
  }

  def formatted_fee
    fee.to_s(:delimited) + '円'
  end
end
