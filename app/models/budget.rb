class Budget < ActiveRecord::Base
  belongs_to :family
  has_many :expenses
end
