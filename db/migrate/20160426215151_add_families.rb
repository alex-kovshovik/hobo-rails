class AddFamilies < ActiveRecord::Migration
  def up
    create_table :families do |t|
      t.string :name
    end

    add_column :users, :family_id, :integer

    User.reset_column_information
    Family.reset_column_information

    # Create default family record for each user.
    User.all.each(&:save!)

    Budget.destroy_all

    rename_column :budgets, :user_id, :family_id
  end

  def down
    # Down migration is not necessary.
  end
end
