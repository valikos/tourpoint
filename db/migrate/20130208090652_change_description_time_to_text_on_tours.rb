class ChangeDescriptionTimeToTextOnTours < ActiveRecord::Migration
  def change
    change_table :tours do |t|
      t.change :description, :text
    end
  end
end
