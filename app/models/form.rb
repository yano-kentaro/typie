class Form
  include ActiveModel::Model
  attr_accessor :title, :code, :name, :color

  with_options presence: true do
    validates :title
    validates :code
    validates :name
    validates :color
  end

  def save
    book = Book.create(title: title, color_id: color)
    strings = code.split(/[\W|\d|\s]+/).uniq.select {|str| str.length != 1}
    strings.each do |string|
      word = Word.where(word: string).first_or_create
      BookWord.create(book_id: book.id, word_id: word.id)
    end
    language = Langage.where(name: name).first_or_create
    BookLanguage.create(book_id: book.id, language_id: language.id)
  end
end