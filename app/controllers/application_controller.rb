class ApplicationController < ActionController::Base
  before_action :set_current_user

  # ここからbefore_actionの定義
  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  #ログインしていないとリダイレクトさせる
  def autheniticate_user
    if @current_user == nil
      flash[:notice] = "ログインが必要です"
      redirect_to login_path
    end  
  end
  #すでにログインしている場合にアクセスを禁止する
  def forbid_login_user
    if @current_user
      flash[:notice]= "すでにログインしています"
      redirect_to posts_path
    end
  end
end
