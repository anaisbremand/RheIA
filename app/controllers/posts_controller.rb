class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  # def create
  #   @post = Post.create(strong_params)
  # end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  # def strong_params
  #   params require(:posts).permit()
  # end
end
