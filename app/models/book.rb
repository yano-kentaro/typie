class Book < ApplicationRecord
  validates :title, presence: true
  validates :color_id, numericality: { other_than: 1 }

  belongs_to :user
  belongs_to :color

  has_many :book_scores
  has_many :scores, through :book_scores
  has_many :book_languages
  has_many :languages, through :book_languages
  has_many :book_words
  has_many :words, through :book_words
end
