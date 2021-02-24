class TypingScore
  include ActiveModel::Model
  attr_accessor :typing_score, :typing_time, :book_id

  with_options presence: true do
    validates :typing_score
    validates :typing_time
    validates :book_id
  end

  def save
    score = Score.create(typing_score: typing_score, typing_time: typing_time)
    BookScore.create(book_id: book_id, score_id: score.id)
  end
end