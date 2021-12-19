class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = user.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    avatar_path = Rails.root.join("app", "assets", "images", "default_icon.jpeg")
    file = File.open(avatar_path)
    @user.avatar.attach(io: file, filename: "default_icon.jpeg")

    if @user.save
      redirect_to root_path(@user)
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = Uesr.find(params[:id])

    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end



  private

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation, :avatar)
  end
end
