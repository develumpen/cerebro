class AddUserToLinks < ActiveRecord::Migration[8.0]
  def change
    add_reference :links, :user, null: false, foreign_key: true
  end
end
