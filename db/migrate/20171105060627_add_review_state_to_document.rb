class AddReviewStateToDocument < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :review_state, :boolean, :default => false
  end
end
