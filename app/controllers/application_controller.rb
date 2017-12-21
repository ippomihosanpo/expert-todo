class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :check_logged_in

  # ログインチェック
  def check_logged_in
    @current_user = User.find_by(id: session[:user])
    unless @current_user
      # ログインしてなければ、ログイン画面に飛ばす
      # ログイン後、リクエストされたページに戻れるようにリファラを渡しとく
      logout
      flash[:referrer] = request.fullpath
      redirect_to "/sessions"
    end
  end

  # セッションのリセット(ログアウト)
  def logout
    session[:user] = nil
    @current_user = nil
  end

end
