class AddIndexToTeamsEmail < ActiveRecord::Migration[5.2]
  def change
    add_index :teams, :email, unique: true
  end
end
