class CreateCustomers < ActiveRecord::Migration[8.0]
  def up
    create_table :customers do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.text :address
      t.string :postal_code, null: false
      t.string :country, null: false
      t.integer :age
      t.string :gender, limit: 1
      t.timestamps
    end
  end

  def down
    drop_table :customers
  end
end
