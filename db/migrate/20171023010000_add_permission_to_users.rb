class AddPermissionToUsers < ActiveRecord::Migration[5.1]
  def up
    change_table :users do |t|
      t.integer :permission, :default => 100
    end
    User.update_all ["permission = ?", 100]
  end

  def down
    remove_column :users, :permission
  end
end