class UsersController < ApplicationController
  before_action :authenticate_user!
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
    user_id = @user.id
    unless user_id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      @user.update(user_params)
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:name,:introduction ,:profile_image)
  end
end
