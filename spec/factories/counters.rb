FactoryGirl.define do
  factory :counter, class: 'Occurro::Counter' do
    association :countable, factory: :dummy_item
    today      { Random.rand 100 }
    yesterday  { Random.rand 100 }
    this_week  { |f| f.today + Random.rand(100) }
    last_week  { Random.rand(100) }
    this_month { |f| f.this_week + Random.rand(100) }
    last_month { Random.rand 100 }
    total      { |f| f.this_month + f.last_month + Random.rand(100) }
  end
end
