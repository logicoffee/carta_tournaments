class AddReferenceToInvitation < ActiveRecord::Migration[5.2]
  def change
    add_reference :invitations, :tournament, foreign_key: true
  end
end
