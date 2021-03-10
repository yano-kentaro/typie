FactoryBot.define do
  factory :language do
    name { Faker::Alphanumeric.alphanumeric(number: 10) }
  end
end
