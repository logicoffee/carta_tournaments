class AddReferenceToTournnamentClassesRanks < ActiveRecord::Migration[5.2]
  def change
    change_column :tournament_classes_ranks, :tournament_class_id, :integer, foreign_key: true
  end
end
