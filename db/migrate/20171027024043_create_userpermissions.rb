class CreateUserpermissions < ActiveRecord::Migration[5.1]
  def change
    create_table :userpermissions do |t|
      t.string :number
      t.integer :userpermission_number_type

      t.timestamps
    end
  end
end
