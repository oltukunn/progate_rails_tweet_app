class UsersController < ApplicationController
  #sessionがnilだったらautheniticate_userメソッドが適応される
  before_action :autheniticate_user,{ only: [:index,:show,:edit,:update] }
  before_action :forbid_login_user,{ only: [:new,:create,:login_form,:login]}
  before_action :ensure_correct_user,{only: [:edit,:update]}
  
  def index
    @users = User.all
  end
  def show
    @user = User.find(params[:id])
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザ登録が完了しました"
      redirect_to user_path(@user)
    else
      render action: :new
    end
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    user = User.find(params[:id])
    if user.image_name
      user.image_name = "#{user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{user.image_name}", image.read)
    end  
    if user.update(user_params)
      flash[:notice]="編集が完了しました"
      redirect_to user_path(user)
    else
      render action: :edit
    end
  end
  #ここからlogin機能
  def login_form
  end
  def login
    @user = User.find_by(
      email:params[:email],
      password:params[:password]
    )
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to action: :index
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render action: :login_form
    end  
  end
  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to action: :login
  end
    #ユーザの編集権限を制限する
  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to posts_path
    end
  end
  def likes
    @user = User.find_by(id:params[:id])
    @likes = Like.where(user_id:@user.id)
  end
  # ここからストロングパラメータ
  private
  def user_params
    params.require(:user).permit(:name,:email,:password)
  end
end
