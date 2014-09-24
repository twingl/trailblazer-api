# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:uid) {|n| "#{n}" }
    name "Jane Bloggs"
    sequence(:email) {|n| "user_#{n}@example.com" }
  end
end
