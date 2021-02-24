class Api::BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @books = Book.where(user_id: current_user.id).includes(:languages, :book_words).order("created_at DESC")
  end

  def new
    @form = Form.new
  end

  def create
    @form = Form.new(form_params)
    if @form.valid?
      @form.save
      redirect_to pages_path
    else
      render :new
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    head :no_content
  end

  def typing
    @words = BookWord.includes(:word).where(book_id: params[:id]).order("RAND()")
  end

  def score
    typing_score = TypingScore.new
    typing_score.save
  end

  private
  def form_params
    params.require(:form).permit(:title, :code, :name, :color).merge(user_id: current_user.id)
  end
end
