class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.integer :external_id
      t.integer :external_order_id
      t.integer :payer_id
      t.integer :installments
      t.string :payment_type
      t.string :status
      t.float :transaction_amount
      t.float :taxes_amount
      t.float :shipping_cost
      t.float :total_paid_amount
      t.float :installment_amount
      t.datetime :date_approved
      t.datetime :date_created
      t.belongs_to :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
