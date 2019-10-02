class UsersController < ApplicationController
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
    render action: :login_form
    end

  #ここからストロングパラメータ
    private
    def user_params
      params.require(:user).permit(:name,:email)
    end
end
