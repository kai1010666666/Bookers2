class UsersController < ApplicationController
  def index
    @book = Book.new
    @users = User.all
  end
  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to user_path(@user.id)
    else
      @user.update(user_params)
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end
