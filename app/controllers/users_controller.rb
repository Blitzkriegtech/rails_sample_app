class UsersController < ApplicationController
  include SessionsHelper

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def index
  end

  def edit
  end

  def update
  end

  def create
    @user = User.new(user_params)
    if @user.save
      reset_session
      log_in @user
      flash[:success] = "Welcome to Microtwitter! Where micro people tweet."
      redirect_to @user
    else
      render "new", status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                    :password_confirmation)
  end
end
