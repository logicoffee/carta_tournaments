class CreateTournaments < ActiveRecord::Migration[5.2]
  def change
    create_table :tournaments do |t|
      t.string   :name,     null: false
      t.datetime :schedule, null: false
      t.string   :venue,    null: false

      t.timestamps
    end
  end
end
