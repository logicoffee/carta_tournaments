class AddDefaultToInvitations < ActiveRecord::Migration[5.2]
  def change
    change_column_default :invitations, :signed_up, false
  end
end
