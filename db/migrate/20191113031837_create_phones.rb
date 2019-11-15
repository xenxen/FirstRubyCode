class CreatePhones < ActiveRecord::Migration[6.0]
  def change
    create_table :phones do |t|
      t.string :area_code
      t.string :number
      t.belongs_to :buyer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
