FactoryGirl.define do
  factory :counter, class: 'Occurro::Counter' do
    association :countable, factory: :dummy_item
    today 0
    yesterday 0
    this_month 0
    last_month 0
    this_week 0
    last_week 0
  end
end
