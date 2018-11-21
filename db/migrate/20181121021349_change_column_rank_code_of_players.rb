class ChangeColumnRankCodeOfPlayers < ActiveRecord::Migration[5.2]
  def change
    remove_column :players, :rank_code, :string
    add_column    :players, :rank,      :integer, null: false
  end
end
