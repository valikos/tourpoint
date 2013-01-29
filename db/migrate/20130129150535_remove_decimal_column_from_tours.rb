class RemoveDecimalColumnFromTours < ActiveRecord::Migration
  def up
    remove_column :tours, :decimal
  end
end
