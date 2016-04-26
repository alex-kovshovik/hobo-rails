# Initially each family would only have one user,
# with the family.name == user.email
class Family < ActiveRecord::Base
  has_many :users
  has_many :budgets
  has_many :expenses, through: :budgets
end
