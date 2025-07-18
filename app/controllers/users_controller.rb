class UsersController < ApplicationController
  include SessionsHelper
  before_action :logged_in_user, only: [ :index, :edit, :update, :destroy ]
  before_action :correct_user, only: [ :edit, :update ]
  before_action :admin_user, only: [ :destroy ]


  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    redirect_to root_url and return unless @user.activated?
  end

  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      render "edit", status: :unprocessable_entity
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render "new", status: :unprocessable_entity
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url, status: :see_other
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                    :password_confirmation)
  end

  # Before filters

  # Confirms a logged in user
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url, status: :see_other
    end
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    unless current_user?(@user)
      flash[:danger] = "Hmmmm HACKER, Nice try diddy."
      redirect_to(root_path, status: :see_other)
    end
  end

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url, status: :see_other) unless current_user.admin?
  end
end
