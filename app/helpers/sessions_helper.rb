module SessionsHelper
  def current_user #今現在ログインしているユーザーを返す。ログインしていなければ、ログインユーザーを検索して取得する。
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  def logged_in? #ログインしているか？していればtrue していなければfalseを返す
    !!current_user
  end
end
