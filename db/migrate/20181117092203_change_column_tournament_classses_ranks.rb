class ChangeColumnTournamentClasssesRanks < ActiveRecord::Migration[5.2]
  def change
    remove_column :tournament_classes_ranks, :tournament_class_id
    add_reference :tournament_classes_ranks, :tournament_class, foreign_key: true
  end
end
