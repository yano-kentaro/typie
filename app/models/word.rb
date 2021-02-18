class Word < ApplicationRecord
  validates :word, presence: true, unique: true

  has_many :book_words
  has_many :books, through :book_words
end
