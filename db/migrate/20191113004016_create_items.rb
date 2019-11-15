class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :external_id
      t.string :title
      t.belongs_to :order_item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
