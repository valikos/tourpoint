class AddPriceColumnToTours < ActiveRecord::Migration
  def change
    add_column :tours, :price, :decimal, precision: 8, scale: 2
  end
end
