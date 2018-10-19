class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations do |t|
      t.string :email
      t.string :invitation_digest
      t.boolean :signed_up, deault: false

      t.timestamps
    end
  end
end
