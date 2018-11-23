class AddExtraAttributesToPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :extra_attributes, :jsonb, null: false
  end
end
