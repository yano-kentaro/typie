json.array! @books do |book|
  json.(book, :title, :color_id)
  json.languages book.languages do |language|
    json.(language, :name)
  end
  json.book_words book.book_words do |word|
    json.(word, :id)
  end
end