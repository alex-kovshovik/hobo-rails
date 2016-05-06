class AddStampsToRecords < ActiveRecord::Migration
  def change
    tables = %i(expenses budgets families)

    tables.each do |table_symbol|
      change_table table_symbol do |t|
        t.integer :created_by
        t.integer :updated_by
        t.string :changed_by
      end
    end

    u = User.first
    if u
      update_sql = "created_by = #{u.id}, updated_by = #{u.id}, changed_by = 'Initial'"
      Expense.update_all(update_sql)
      Budget.update_all(update_sql)
      Family.update_all(update_sql)
      User.update_all(update_sql)
    end
  end
end
