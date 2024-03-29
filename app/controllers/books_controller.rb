class BooksController < ApplicationController
    before_action :authenticate_user!
  def index
    @book = Book.new
    @books = Book.all
  end
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      @books = Book.all
      render :index
    end
  end
  def show
    @booka = Book.new
    @book = Book.find(params[:id])
  end
  def edit
    @book = Book.find(params[:id])
    user_id = @book.user.id
    unless user_id == current_user.id
      redirect_to books_path
    end
  end
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      @book.update(book_params)
      render :edit
    end
  end
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end
  private
  
  def book_params
    params.require(:book).permit(:title,:image,:body)
  end
end
