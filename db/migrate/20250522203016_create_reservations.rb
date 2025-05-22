class CreateReservations < ActiveRecord::Migration[8.0]
  def up
    create_table :reservations do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :representation, null: false, foreign_key: true
      t.references :seller, null: false, foreign_key: true
      t.datetime :reserved_at, null: false
      t.timestamps
    end
  end

  def down
    drop_table :reservations
  end
end
