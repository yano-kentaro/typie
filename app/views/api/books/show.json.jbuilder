json.id @book.id
json.title @book.title
json.language @book.languages.first.name
json.score @book.scores.sort{|a, b| b.typing_score <=> a.typing_score}.slice(0, 5).map{|h| h[:typing_score]}