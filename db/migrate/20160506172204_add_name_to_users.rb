class AddNameToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.integer :created_by
      t.integer :updated_by
      t.string :changed_by
    end
  end
end
