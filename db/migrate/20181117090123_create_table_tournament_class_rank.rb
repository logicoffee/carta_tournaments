class CreateTableTournamentClassRank < ActiveRecord::Migration[5.2]
  def change
    create_table :tournament_classes_ranks do |t|
      t.integer :tournament_class_id, null: false
      t.integer :rank, null: false
    end
  end
end
