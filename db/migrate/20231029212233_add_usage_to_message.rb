class AddUsageToMessage < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :usage, :jsonb, default: {}
  end
end
