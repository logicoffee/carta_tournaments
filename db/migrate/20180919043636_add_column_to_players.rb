class AddColumnToPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :deleted, :boolean, default: false
  end
end
