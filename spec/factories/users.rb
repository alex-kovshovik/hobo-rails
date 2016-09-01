FactoryGirl.define do
  factory :user do
    email 'admin@example.com'

    initialize_with { User.find_or_initialize_by(email: email) }
  end
end
