class User < ApplicationRecord
  belongs_to :family
  has_many :budgets, through: :family

  before_create do |user|
    user.api_key = user.generate_api_key
  end

  after_create do |user|
    new_family = Family.create(name: email)

    user.family = new_family
    user.save!
  end

  after_create do |user|
    Budget::DEFAULTS.each do |budget_name|
      next if user.family.budgets.where(name: budget_name).exists?

      user.family.budgets << Budget.new(name: budget_name, amount: 100.0)
    end
  end

  delegate :expenses, :budgets, to: :family

  protected

  def generate_api_key
    loop do
      token = SecureRandom.base64.tr('+/=', 'Qrt')
      break token unless User.exists?(api_key: token)
    end
  end
end
