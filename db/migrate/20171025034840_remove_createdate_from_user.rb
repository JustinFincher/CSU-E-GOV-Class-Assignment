class RemoveCreatedateFromUser < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :createdate, :datetime
  end
end
