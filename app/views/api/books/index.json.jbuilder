json.array! @books do |book|
  json.(book, :id, :title, :color_id)
  json.language book.languages.first.name
  json.book_words book.book_words.length
  json.score book.scores.max{|a, b| a.typing_score.to_i <=> b.typing_score.to_i}.typing_score
end
