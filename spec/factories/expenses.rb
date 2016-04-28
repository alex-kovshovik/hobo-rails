FactoryGirl.define do
  factory :expense do
    budget

    amount 50.0
    comment 'No comment'
  end
end
