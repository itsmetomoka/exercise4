class UsersController < ApplicationController
		before_action :authenticate_user!
  def show
  	@user = User.find(params[:id])
    @book = Book.new
    @books = @user.books

  end
  def edit
  	@user = User.find(params[:id])
    if current_user.id != @user.id
      redirect_to user_path(current_user)
    end
  end

  def update
  	@user = User.find(params[:id])
    if@user.update(user_params)
      flash[:notice] = "your profile was updated successfully"
  	   redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def index
    @users =User.all
    @book = Book.new
  end

  def follow
      @user = User.find(params[:user_id])
      current_user.follow(@user)
      redirect_back(fallback_location: root_path)
  end
#フォローする

  def unfollow
      @user = User.find(params[:user_id])
      current_user.stop_following(@user)
      redirect_back(fallback_location: root_path)
  end
#フォローを外す


  def follow_list
    @user = User.find(params[:user_id])
  end
#フォローしてる人の一覧ページ

  def follower_list
    @user = User.find(params[:user_id])
  end

  private
  def user_params
  	params.require(:user).permit(:name, :profile_image, :introduction)
  end
end

