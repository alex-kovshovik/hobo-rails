class AddBudgetsSchema < ActiveRecord::Migration
  def change
    create_table "budgets" do |t|
      t.integer  "user_id",    null: false, index: true
      t.string   "name"
      t.decimal  "amount",     precision: 12, scale: 2
      t.string   "mode",       limit: 32, default: "normal", null: false
      t.timestamps
    end

    create_table "expenses" do |t|
      t.integer  "budget_id", null: false, index: true
      t.decimal  "amount",    precision: 12, scale: 2, null: false
      t.string   "comment"
      t.timestamps
    end
  end
end
