class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :primary_contact
      t.string :secondary_contact
      t.string :email
      t.string :address
      t.string :status
      t.integer :credit_limit
      t.references :service_area, null: false

      t.timestamps
    end
  end
end
