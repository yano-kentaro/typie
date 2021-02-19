class Score < ApplicationRecord
  validetes :typing_score, presence: true, numericality: true
  validates :typing_time, presence:true

  belongs_to :user

  has_many :book_scores
  has_many :books, through :book_scores
end
