# blogs controller
class BlogsController < ApplicationController
  before_action :blog_find_params, only: %i[edit show update destroy]
  before_action :please_login, only: %i[new edit show]

  def index
    @blogs = Blog.all.order('created_at desc')
    @user = User.find_by(id: session[:user_id])
  end

  def new
    @blog = if params[:back]
              current_user.blogs.new(strong_params)
            else
              current_user.blogs.new
            end
  end

  def create
    @blog = current_user.blogs.new(strong_params)
    @blog.user_id = current_user.id
    @blog.name = current_user.name
    if @blog.image?
      @blog.image.retrieve_from_cache! params[:cache][:image]
      @blog.save
    end
    if @blog.save
      #ブログに紐付いているユーザーのにメールを送る
      BlogMailer.blog_mail(@blog).deliver
      redirect_to blogs_path, notice: 'ブログを作成しました'
    else
      render 'new'
    end
  end

  def edit; end

  def show
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end

  def update
    if @blog.update(strong_params)
      redirect_to blogs_path, notice: 'ブログを編集しました'
    else
      render 'edit'
    end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_path, notice: 'ブログを削除しました'
  end

  def confirm
    @blog = current_user.blogs.new(strong_params)
    render 'new' if @blog.invalid?
  end

  private

  def strong_params
    params.require(:blog).permit(:title, :content, :image, :image_cache)
  end

  def blog_find_params
    @blog = Blog.find(params[:id])
  end

  def please_login
    redirect_to new_session_path unless logged_in?
  end
end
