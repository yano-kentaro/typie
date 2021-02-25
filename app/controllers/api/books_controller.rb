class Api::BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @books = Book.where(user_id: current_user.id).includes(:languages, :book_words, :scores).order("created_at DESC")
  end

  def new
    @form = Form.new
  end

  def create
    @form = Form.new(form_params)
    if @form.valid?
      if @form.save?
        @form.save
        redirect_to pages_path
      else
        render :new
      end
    else
      render :new
    end
  end

  def edit
    @book = Book.find(params[:id])
    @form = Form.new(book: @book)
  end

  def update
    @book = Book.find(params[:id])
    @form = Form.new(form_params, )
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
    score = Score.new(score_params)
    score.save
  end

  private
  def form_params
    params.require(:form).permit(:title, :code, :name, :color).merge(user_id: current_user.id)
  end

  def score_params
    params.require(:score).permit(:typing_score, :typing_time, :book_id)
  end
end
