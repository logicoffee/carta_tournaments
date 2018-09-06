class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :leader
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
