class CreateKbDocuments < ActiveRecord::Migration[7.1]
  def change
    create_table :kb_documents do |t|
      t.string :name
      t.integer :num_pages
      t.text :summary
      t.vector :summary_embedding, limit: 1536

      t.timestamps
    end
  end
end
