class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
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
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to profile_user_path(@user), notice: "変更が完了しました"
    elsif @user.errors[:name].any? || @user.errors[:avatar].any?
      render :profile
    else
      render :security
    end
  end

  def profile
    @user = User.find(params[:id])
  end

  def security
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation, :avatar)
  end
end
