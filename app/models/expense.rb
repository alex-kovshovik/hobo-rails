class Expense < ActiveRecord::Base
  belongs_to :budget

  validates :amount, presence: true
end
