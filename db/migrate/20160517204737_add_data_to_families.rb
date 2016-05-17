class AddDataToFamilies < ActiveRecord::Migration
  def change
    change_table :families do |t|
      t.string :currency, default: 'USD', null: false
      t.integer :timezone, default: -4, null: false
    end
  end
end
