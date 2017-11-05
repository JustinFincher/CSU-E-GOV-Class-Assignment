class AddReviewsToDocument < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :reviews, :text, array:true, default:[].to_yaml
  end
end
