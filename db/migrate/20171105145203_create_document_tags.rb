class CreateDocumentTags < ActiveRecord::Migration[5.1]
  def change
    create_table :document_tags do |t|

      t.timestamps
    end
  end
end
