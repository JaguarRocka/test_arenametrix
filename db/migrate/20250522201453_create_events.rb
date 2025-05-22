class CreateEvents < ActiveRecord::Migration[8.0]
  def up
    create_table :events do |t|
      t.string :name, null: false
      t.timestamps
    end
  end

  def down
    drop_table :events
  end
end
