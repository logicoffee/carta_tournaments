class AddTimestampsToJoinTables < ActiveRecord::Migration[5.2]
  def change
    add_timestamps :tournament_classes_players,   null: false
    add_timestamps :tournament_divisions_players, null: false
  end
end
