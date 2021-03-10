FactoryBot.define do
  factory :book do
    title { Faker::Alphanumeric.alphanumeric(number: 10) }
    color { Faker::Color.hex_color }
  end
end
