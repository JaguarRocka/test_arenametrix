class CreateTickets < ActiveRecord::Migration[8.0]
  def up
    create_table :tickets do |t|
      t.string :ticket_number, null: false
      t.references :reservation, null: false, foreign_key: true
      t.float :price, null: false
      t.string :category, null: false
      t.timestamps
    end
  end

  def down
    drop_table :tickets
  end
end
