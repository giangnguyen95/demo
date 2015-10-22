class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit,:update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page])
    #@users = User.all
  end

  def show
  	@user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
      # Handle a successful save.
    else
      render 'new'
    end
  end

  def edit
      @user = User.find(params[:id])
  end  

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      #handle a successful update
      flash[:success] = "Profile update"
      redirect_to @user
    else
      render 'edit'
    end

  def destroy
    user.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to user_url
  end


  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
    # Before filters

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in"
      redirect_to login_url
    end
    
  end
 
  #Confirms the correct user
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
