class Word < ApplicationRecord
  validates :word, presence: true, format: { with: /\A[a-zA-Z_]{2,}\z/, message: "半角英字2文字以上の入力が必要です" }

  has_many :book_words
  has_many :books, through: :book_words
end
