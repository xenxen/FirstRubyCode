class CreateSyncs < ActiveRecord::Migration[6.0]
  def change
    create_table :syncs do |t|
      t.datetime :date_created
      t.datetime :date_processed
      t.string :sender_ip
      t.text :payload
      t.string :status
      t.string :storeId
      t.string :externalCode
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
