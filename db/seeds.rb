user = User.create!(email: 'kovshovik.alexandr@gmail.com', password: '12341234', password_confirmation: '12341234')

grocery = Budget.create!(family_id: user.family_id, name: 'Grocery')
kids = Budget.create!(family_id: user.family_id, name: 'Kids')
Budget.create!(family_id: user.family_id, name: 'Utility')
Budget.create!(family_id: user.family_id, name: 'Other')

Expense.create!(budget_id: grocery.id, amount: 52.13, comment: 'no comment')
Expense.create!(budget_id: kids.id, amount: 14.43)
Expense.create!(budget_id: grocery.id, amount: 114.77)
