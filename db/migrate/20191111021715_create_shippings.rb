class CreateShippings < ActiveRecord::Migration[6.0]
  def change
    create_table :shippings do |t|
      t.integer :external_id
      t.string :shipment_type
      t.datetime :date_created
      t.references :receiver_address, null: false, foreign_key: true

      t.timestamps
    end
  end
end
