class CreateSellers < ActiveRecord::Migration[8.0]
  def up
    create_table :sellers do |t|
      t.string :name, null: false
      t.timestamps
    end
  end

  def down
    drop_table :sellers
  end
end
