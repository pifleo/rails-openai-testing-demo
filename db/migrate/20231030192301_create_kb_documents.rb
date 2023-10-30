class CreateKbDocuments < ActiveRecord::Migration[7.1]
  def change
    create_table :kb_documents do |t|
      t.string :name
      t.text :content

      t.timestamps
    end
  end
end
