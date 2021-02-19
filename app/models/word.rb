class Word < ApplicationRecord
  validates :word, presence: true, uniqueness: true

  has_many :book_words
  has_many :books, through: :book_words
end
