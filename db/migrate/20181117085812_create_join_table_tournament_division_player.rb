class CreateJoinTableTournamentDivisionPlayer < ActiveRecord::Migration[5.2]
  def change
    create_join_table :tournament_divisions, :players do |t|
    end
  end
end
