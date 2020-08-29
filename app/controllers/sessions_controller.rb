class SessionsController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  
  def new
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email,password)
      flash[:success] = "ログインに成功しました。"
      redirect_to root_url
    else
      flash.now[:danger] = "ログインに失敗しました。"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "ログアウトしました。"
    redirect_to root_url
  end
  
  private
  
  def login(email,password)
    @user = User.find_by(email: email) #入力フォームのemailと同じemailをもつuserをデータベースから検索し、@userへ代入
    if @user && @user.authenticate(password) #検索結果がtrueとなった@userが見つかれば、パスワードが入っているか確認
      #⇓ログイン成功後
      session[:user_id] = @user.id #ブラウザにcookieとして、サーバにsessionして、useridを保持
      return true
    else #ログインに失敗した時
      return false
    end
  end

end

