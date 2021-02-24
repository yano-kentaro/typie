json.id @book.id
json.title @book.title
json.language @book.languages.first.name
json.score @book.scores.map{|h| h[:typing_score]}.sort{|a, b| b.to_i <=> a.to_i}.slice(0, 5)
json.time @book.scores.sort{|a, b| b.typing_score.to_i <=> a.typing_score.to_i}.map{|h| h[:typing_time]}.slice(0, 5)