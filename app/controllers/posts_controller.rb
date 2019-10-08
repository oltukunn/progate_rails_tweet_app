class PostsController < ApplicationController
  before_action :autheniticate_user
  before_action :ensure_correct_user,{only:[:edit,:update,:destroy]}

  def index
    @posts = Post.all.order(created_at: :desc)
  end
  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @likes_count = Like.where(post_id:@post.id).count
  end
  def new
    @post = Post.new
  end
  def create
    post = Post.new(post_params)
    post.user_id = @current_user.id
    if post.save
      flash[:notice]= "投稿を作成しました"
      redirect_to action: :index
    else
      render action: :new
    end
  end
  def edit
    @post = Post.find(params[:id])
  end
  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      flash[:notice]= "投稿を編集しました"
      redirect_to action: :index
    else
      render action: :edit
    end
  end
  def destroy
    post = Post.find(params[:id])
    post.delete
    flash[:notice]= "投稿を削除しました"
    redirect_to action: :index
  end

  def ensure_correct_user
    @post = Post.find(params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to action: :index
    end

  end

  private
  def post_params
    params.require(:post).permit(:content)
  end

end
