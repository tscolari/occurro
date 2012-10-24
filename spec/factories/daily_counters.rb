FactoryGirl.define do
  factory :daily_counter, class: 'Occurro::DailyCounter' do
    association :countable, factory: :dummy_item
    created_on Date.today
    counter 0
  end
end
