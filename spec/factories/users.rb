FactoryGirl.define do
  factory :user do
    email 'admin@example.com'
    password '12341234'
    password_confirmation { password }

    initialize_with { User.find_or_initialize_by(email: email) }
  end
end
