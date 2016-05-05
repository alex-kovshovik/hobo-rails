class Budget < ActiveRecord::Base
  DEFAULTS = %w(Grocery Utility Gas Other)

  belongs_to :family
  has_many :expenses

  validates :name, presence: true
end
