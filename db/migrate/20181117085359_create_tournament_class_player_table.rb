class CreateTournamentClassPlayerTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :tournament_classes, :players
  end
end
