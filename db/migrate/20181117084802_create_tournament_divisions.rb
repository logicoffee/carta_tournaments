class CreateTournamentDivisions < ActiveRecord::Migration[5.2]
  def change
    create_table :tournament_divisions do |t|
      t.references :tournament_class, foreign_key: true, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
