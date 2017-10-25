class RemoveModifieddateFromUser < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :modifieddate, :datetime
  end
end
