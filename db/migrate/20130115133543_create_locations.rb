class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :title, limit: 255, null: false
      t.text :description, null: false
      t.float :latitude
      t.float :longitude
      t.integer :tour_id, null: false

      t.timestamps
    end
  end
end
