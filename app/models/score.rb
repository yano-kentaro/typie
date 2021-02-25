class Score < ApplicationRecord
  validates :typing_score, presence: true
  validates :typing_time, presence: true

  belongs_to :book
end
