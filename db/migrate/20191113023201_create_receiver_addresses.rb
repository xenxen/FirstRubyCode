class CreateReceiverAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :receiver_addresses do |t|
      t.integer :external_id
      t.string :address_line
      t.string :street_name
      t.string :street_number
      t.string :comment
      t.string :zip_code
      t.string :latitude
      t.string :longitude
      t.string :receiver_phone
      t.references :city, null: false, foreign_key: true
      t.references :state, null: false, foreign_key: true
      t.references :country, null: false, foreign_key: true
      t.references :neighborhood, null: false, foreign_key: true
      t.belongs_to :shipping, null: false, foreign_key: true

      t.timestamps
    end
  end
end
