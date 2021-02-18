class Book < ApplicationRecord
  validates :title, presence: true

  belongs_to :user

  has_many :book_scores
  has_many :scores, through :book_scores
  has_many :book_languages
  has_many :languages, through :book_languages
  has_many :book_words
  has_many :words, through :book_words
end
