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

    if @user.save
      redirect_to multiwatch_home_path(@user)
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
