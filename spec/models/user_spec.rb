require "rails_helper"

describe User do
  it 'creates default budgets' do
    user = create(:user)

    expect(user.budgets.count).to be > 0
  end

  it 'generates secure api key' do
    user = create(:user)

    expect(user.api_key).not_to be_empty
  end
end
