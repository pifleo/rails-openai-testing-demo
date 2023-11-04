class CreateKbPages < ActiveRecord::Migration[7.1]
  def change
    create_table :kb_pages do |t|
      t.uuid :uuid, default: 'gen_random_uuid()', null: false
      t.references :kb_document, null: false, foreign_key: true
      t.integer :page_index, null: false, default: 1
      t.text :content

      t.timestamps
    end

    add_index :kb_pages, [:kb_document_id, :page_index], unique: true
  end
end
