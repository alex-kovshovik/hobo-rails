FactoryGirl.define do
  factory :family do
    name 'Shoviks'

    initialize_with { Family.find_or_initialize_by(name: name) }
  end
end
