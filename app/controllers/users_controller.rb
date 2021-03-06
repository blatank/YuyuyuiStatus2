class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      # ユーザ登録時にログイン
      log_in @user
      
      flash[:success] = "ユーザ登録が完了しました"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
