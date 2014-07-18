# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :node do
    url ""
    title "MyString"
    arrived_at "2014-07-10 00:51:12"
    departed_at "2014-07-10 00:51:12"
    idle ""
    assignment nil
    parent nil
    user nil
  end
end
