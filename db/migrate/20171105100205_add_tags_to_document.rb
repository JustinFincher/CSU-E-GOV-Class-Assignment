class AddTagsToDocument < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :tags, :text, array:true, default:[].to_yaml
  end
end
