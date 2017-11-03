class AddToReviewDocumentsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :to_review_documents, :text, array:true, default:[].to_yaml
  end
end
