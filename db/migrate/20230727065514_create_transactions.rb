class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :transaction_type, null: false
      t.integer :amount, null: false
      t.string :description
      t.datetime :date
      t.references :customer, null: false

      t.timestamps
    end
  end
end
