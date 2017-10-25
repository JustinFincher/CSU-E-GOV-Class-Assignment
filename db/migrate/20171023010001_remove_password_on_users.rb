class RemovePasswordOnUsers < ActiveRecord::Migration[5.1]
  def down
    change_table :users do |t|
      t.string :password
    end
  end

  def up
    remove_column :users, :password
  end
end