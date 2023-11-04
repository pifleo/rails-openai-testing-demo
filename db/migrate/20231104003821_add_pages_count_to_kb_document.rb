class AddPagesCountToKbDocument < ActiveRecord::Migration[7.1]
  def change
    add_column :kb_documents, :pages_count, :integer
  end
end
