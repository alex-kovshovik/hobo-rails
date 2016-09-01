class Expense < ApplicationRecord
  belongs_to :budget

  validates :amount, presence: true
end
