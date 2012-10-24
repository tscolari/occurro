FactoryGirl.define do
  factory :daily_counter, class: 'Occurro::DailyCounter' do
    association :countable, factory: :dummy_item
    created_on Date.today
    total { Random.rand 100 }
  end
end
