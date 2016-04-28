FactoryGirl.define do
  factory :budget do
    family
    name 'Grocery'

    initialize_with { Budget.find_or_initialize_by(family_id: family.id, name: name) }
  end
end
