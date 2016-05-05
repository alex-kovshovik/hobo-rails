require "rails_helper"

describe User do
  it 'creates default budgets' do
    user = create(:user)

    expect(user.budgets.count).to be > 0
  end
end
