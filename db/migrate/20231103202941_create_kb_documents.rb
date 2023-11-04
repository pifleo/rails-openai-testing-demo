class CreateKbDocuments < ActiveRecord::Migration[7.1]
  def change
    create_table :kb_documents do |t|
      t.uuid :uuid, default: 'gen_random_uuid()', null: false

      t.string :name
      t.text :summary
      t.vector :summary_embedding, limit: 1536

      t.timestamps
    end
  end
end
