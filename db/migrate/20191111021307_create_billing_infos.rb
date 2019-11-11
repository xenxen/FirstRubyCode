class CreateBillingInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :billing_infos do |t|
      t.string :doc_type
      t.string :doc_number

      t.timestamps
    end
  end
end
