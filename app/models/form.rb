class Form
  include ActiveModel::Model
  attr_accessor :title, :code, :name, :color, :user_id

  with_options presence: true do
    validates :title
    validates :code
    validates :name
    validates :color
    validates :user_id
  end

  def save
    book = Book.create(title: title, color: color, user_id: user_id)
    strings = code.split(/[\W|\d|\s]+/).uniq.select {|str| str.length != 1}
    strings.each do |string|
      word = Word.where(word: string).first_or_create
      BookWord.create(book_id: book.id, word_id: word.id)
    end
    language = Language.where(name: name).first_or_create
    BookLanguage.create(book_id: book.id, language_id: language.id)
    score = TypingScore.new
    score.typing_score = "0"
    score.typing_time = "0"
    score.book_id = book.id
    score.save
  end
end