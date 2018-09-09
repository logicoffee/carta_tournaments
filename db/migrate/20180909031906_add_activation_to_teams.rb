class AddActivationToTeams < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :activation_digest, :string
    add_column :teams, :activated, :boolean, default: false
    add_column :teams, :activated_at, :datetime
  end
end
