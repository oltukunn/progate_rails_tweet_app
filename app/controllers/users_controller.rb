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

    private
    def user_params
      params.require(:user).permit(:name,:email,:image_name)
    end
end
