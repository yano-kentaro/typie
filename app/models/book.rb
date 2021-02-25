class Book < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  validates :title, presence: true
  validates :color_id, presence: true, numericality: { other_than: 1 }

  belongs_to :user
  belongs_to :color

  has_many :book_scores, dependent: :destroy
  has_many :scores, through: :book_scores
  has_many :book_languages, dependent: :destroy
  has_many :languages, through: :book_languages
  has_many :book_words, dependent: :destroy
  has_many :words, through: :book_words
end
