module SessionsHelper
  
  # ログイン記憶
  def log_in(user)
    # sessionにユーザIDを記憶
    session[:user_id] = user.id
  end
  
  # カレントユーザーを返す
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
  
  # ログイン状態を返す
  def logged_in?
    # current_userがnilではなかったらログインしていることになる
    !current_user.nil?
  end
end
