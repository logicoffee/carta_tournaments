class RenameTable < ActiveRecord::Migration[5.2]
  def change
    rename_table :players_tournament_classes,   :tournament_classes_players
    rename_table :players_tournament_divisions, :tournament_divisions_players
  end
end
