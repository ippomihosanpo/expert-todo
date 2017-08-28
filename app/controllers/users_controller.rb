class UsersController < ApplicationController
  skip_before_action :logged_in?, only: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  def index
    # ユーザー一覧にアクセスできないように
    # @users = User.all
    redirect_to edit_user_path(@current_user)
  end

  # GET /users/1
  def show
    # 他のユーザー情報にアクセスできないように
    redirect_to edit_user_path(@current_user)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    # 他のユーザー情報にアクセスできないように
    unless @user.id == @current_user.id
      redirect_to edit_user_path(@current_user)
    end
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      # ログイン情報を登録
      session[:user] = @user.id
      redirect_to '/', notice: 'ユーザー登録が完了しました'
    else
      render action: :new
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to edit_user_path(@user), notice: 'ユーザー情報を更新しました'
    else
      render action: :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(User::REGISTRABLE_ATTRIBUTES)
    end
end
