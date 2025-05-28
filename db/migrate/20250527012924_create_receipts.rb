class CreateReceipts < ActiveRecord::Migration[8.0]
  def change
    create_table :receipts do |t|
      t.datetime :purchased_at
      t.text :description, null: false
      t.integer :amount
      t.string :currency

      t.timestamps
    end
  end
end
