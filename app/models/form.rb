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

  def save?
    strings = code.split(/[\W|\d|\s]+/).uniq.select {|str| str.length != 1}
    unless strings.empty?
      true
    else
      false
    end
  end

  def save
    ActiveRecord::Base.transaction do
      book = Book.create(title: title, color: color, user_id: user_id)
      strings = code.split(/[\W|\d|\s]+/).uniq.select {|str| str.length != 1}
      strings.each do |string|
        word = Word.where(word: string).first_or_create
        BookWord.create(book_id: book.id, word_id: word.id)
      end
      language = Language.where(name: name).first_or_create
      BookLanguage.create(book_id: book.id, language_id: language.id)
      score = Score.new
      score.typing_score = "0"
      score.typing_time = "0"
      score.book_id = book.id
      score.save
    end
  end

  def update
    ActiveRecord::Base.transaction do
      @book.update(title: title, color: color, user_id: user_id)
      @book.book_languages.find{ |a| a[:book_id] == @book.id }.delete
      @book.book_words.each do |i|
        i.delete
      end
      strings = code.split(/[\W|\d|\s]+/).uniq.select {|str| str.length != 1}
      strings.each do |string|
        word = Word.where(word: string).first_or_create
        BookWord.create(book_id: @book.id, word_id: word.id)
      end
      language = Language.where(name: name).first_or_create
      BookLanguage.create(book_id: @book.id, language_id: language.id)
    end
  end

  def to_model
    Form
  end

  delegate :persisted?, to: :book

  def initialize(attributes = nil, book: Book.new)
    @book = book
    attributes ||= default_attributes
    super(attributes)
  end

  private

  attr_reader :book

  def default_attributes
    {
      title: book.title,
      color: book.color,
      code: book.words.pluck(:word).join(','),
      name: book.languages.pluck(:name).join(',')
    }
  end
end