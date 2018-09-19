class ChangeColumnToPlayersDeleted < ActiveRecord::Migration[5.2]
  def change
    change_column_null :players, :deleted, false
  end
end
