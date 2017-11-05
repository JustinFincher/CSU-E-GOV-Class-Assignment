class AddReviewedDocumentsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :reviewed_documents, :text, array:true, default:[].to_yaml
  end
end
