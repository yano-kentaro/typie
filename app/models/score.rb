class Score < ApplicationRecord
  validates :typing_score, presence: true
  validates :typing_time, presence: true

  has_many :book_scores
  has_many :books, through: :book_scores
end
