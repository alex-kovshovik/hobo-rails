class SetDefaultFirstAndLastNames < ActiveRecord::Migration
  def up
    User.update_all("first_name = 'Alex'")
    User.update_all("last_name = 'Kovshovik'")

    # This is for Elm :)
    change_column :users, :first_name, :string, null: false, default: ''
    change_column :users, :last_name, :string, null: false, default: ''
  end
end
