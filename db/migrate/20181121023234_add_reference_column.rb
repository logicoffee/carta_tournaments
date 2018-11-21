class AddReferenceColumn < ActiveRecord::Migration[5.2]
  def change
    add_reference :tournament_classes, :tournament, foreign_key: true
    add_reference :admins,             :tournament, foreign_key: true
  end
end
