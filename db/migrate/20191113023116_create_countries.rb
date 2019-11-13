class CreateCountries < ActiveRecord::Migration[6.0]
  def change
    create_table :countries do |t|
      t.string :external_id
      t.string :name

      t.timestamps
    end
  end
end
