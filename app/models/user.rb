class User < ActiveRecord::Base
  acts_as_token_authenticatable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :family

  before_save :set_family

  delegate :expenses, :budgets, to: :family

  private

  def set_family
    return if family

    self.family = Family.create(name: email)
  end
end
