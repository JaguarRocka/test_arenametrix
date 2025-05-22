class CreateRepresentations < ActiveRecord::Migration[8.0]
  def up
    create_table :representations do |t|
      t.references :event, null: false, foreign_key: true
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false
      t.date :date, null: false # pour éviter l'affichage avec 00:00
      t.timestamps
    end
  end

  def down
    drop_table :representations
  end
end
