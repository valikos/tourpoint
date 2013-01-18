class CreateTours < ActiveRecord::Migration
  def change
    create_table :tours do |t|
      t.string  :title, limit: 255
      t.string  :description, limit: 255
      t.decimal :price, :decimal, precision: 8, scale: 2
      t.boolean :active, default: true
      t.date    :start_date
      t.date    :end_date

      t.timestamps
    end
  end
end
