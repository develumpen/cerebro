class CreateLinks < ActiveRecord::Migration[8.0]
  def change
    create_table :links do |t|
      t.string :url, null: false
      t.string :title, null: false
      t.text :description

      t.timestamps
    end
  end
end
