class Language < ApplicationRecord
  has_many :book_languages
  has_many :books, through: :book_languages

  validates :name, presence: true, uniqueness: true
end