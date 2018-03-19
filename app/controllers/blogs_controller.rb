# blogs controller
class BlogsController < ApplicationController
  before_action :blog_find_params, only: %i[edit show update destroy]
  before_action :please_login, only: %i[new edit show]

  def index
    @blogs = Blog.all.order('created_at desc')
  end

  def new
    @blog = if params[:back]
              Blog.new(strong_params)
            else
              Blog.new
            end
  end

  def create
    @blog = Blog.new(strong_params)
    if @blog.save
      redirect_to blogs_path, notice: 'ブログを作成しました'
    else
      render 'new'
    end
  end

  def edit; end

  def show; end

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
    @blog = Blog.new(strong_params)
    render 'new' if @blog.invalid?
  end

  private

  def strong_params
    params.require(:blog).permit(:title, :content)
  end

  def blog_find_params
    @blog = Blog.find(params[:id])
  end

  def please_login
    redirect_to new_session_path unless logged_in?
  end
end
