class User < ActiveRecord::Base
  acts_as_token_authenticatable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  belongs_to :family

  after_create :set_family, :create_default_budgets

  delegate :expenses, :budgets, to: :family

  private

  def set_family
    new_family = Family.create(name: email)

    self.family = new_family
    self.save!
  end

  def create_default_budgets
    Budget::DEFAULTS.each do |budget_name|
      next if self.family.budgets.where(name: budget_name).exists?

      self.family.budgets << Budget.new(name: budget_name, amount: 100.0)
    end
  end
end
