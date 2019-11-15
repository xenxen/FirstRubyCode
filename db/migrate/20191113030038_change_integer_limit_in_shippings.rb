class ChangeIntegerLimitInShippings < ActiveRecord::Migration[6.0]
  def change
    change_column :shippings, :external_id, :integer, limit: 8
  end
end
