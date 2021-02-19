class Api::BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    # @books = Books.where(user_id: current_user.id)
  end

  def new
    @form = Form.new
  end

  def create
    @form = Form.new(form_params)
    if @form.valid?
      @form.save
      redirect_to api_books_path
    else
      render :new
    end
  end

  private
  def form_params
    params.require(:form).permit(:title, :code, :name, :color).merge(user_id: current_user.id)
  end
end
