json.array! @books do |book|
  json.(book, :title, :color_id)
  json.language book.languages.first.name
  json.book_words book.book_words.length
end
