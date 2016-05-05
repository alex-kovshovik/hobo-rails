class User < ActiveRecord::Base
  acts_as_token_authenticatable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :family

  before_save :set_family
  after_create :create_default_budgets

  delegate :expenses, :budgets, to: :family

  private

  def set_family
    return if family

    self.family = Family.create(name: email)
  end

  def create_default_budgets
    Budget::DEFAULTS.each do |budget_name|
      self.family.budgets << Budget.new(name: budget_name, amount: 100.0)
    end
  end
end
