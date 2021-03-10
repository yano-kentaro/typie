class Language < ApplicationRecord
  has_many :book_languages
  has_many :books, through: :book_languages

  validates :name, presence: true, format: { with: /\A[\w-]{1,12}\z/, message: '半角英数12文字以内の入力が必要です' }
end
