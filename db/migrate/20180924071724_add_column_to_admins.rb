class AddColumnToAdmins < ActiveRecord::Migration[5.2]
  def change
    add_column :admins, :name, :string
    add_index  :admins, :email, unique: true
  end
end
