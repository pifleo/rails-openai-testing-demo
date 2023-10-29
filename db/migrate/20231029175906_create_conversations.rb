class CreateConversations < ActiveRecord::Migration[7.1]
  def change
    create_table :conversations do |t|
      t.float :temperature
      t.text :init_system_message
      t.string :model
      t.belongs_to :token, null: false, foreign_key: true

      t.timestamps
    end
  end
end
