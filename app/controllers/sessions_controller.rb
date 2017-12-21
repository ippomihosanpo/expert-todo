class SessionsController < ApplicationController
  # ログイン画面ではログインチェック飛ばす
  skip_before_action :check_logged_in

  def index
  end

  def create
    @user = User.find_by(email: session_params[:email])
    if @user.present? && @user.authenticate(session_params[:password])
      # ログインOK
      logout
      session[:user] = @user.id
      redirect_to params[:referer].presence || '/', notice: 'ログインしました'
    else
      # ログインNG
      flash.now[:referer] = params[:referer]
      flash.now[:error_message] = 'ユーザー名またはパスワードが違います'
      render :index
    end
  end

  # ログアウト
  def delete
    logout
    redirect_to sessions_url, notice: 'ログアウトしました'
  end

  private
    def session_params
      params.require(:user).permit(:email, :password)
    end
end
