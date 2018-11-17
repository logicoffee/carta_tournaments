class CreateTournamentClasses < ActiveRecord::Migration[5.2]
  def change
    create_table :tournament_classes do |t|
      t.string :name, null: false
      t.integer :fee, null: false

      t.timestamps
    end
  end
end
