class CreateBuyers < ActiveRecord::Migration[6.0]
  def change
    create_table :buyers do |t|
      t.integer :external_id
      t.string :nickname
      t.string :email
      t.string :first_name
      t.string :last_name
      t.references :phone, null: false, foreign_key: true
      t.references :billing_info, null: false, foreign_key: true
      t.timestamps
    end
  end
end
