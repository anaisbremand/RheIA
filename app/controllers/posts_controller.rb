class PostsController < ApplicationController
  def new
    @post = Post.new

    # respond_to do |format|
    #   if @post.save
    #     format.html { redirect_to post_path(@post) }
    #     format.json
    #   else
    #     format.html { render "posts/show", status: :unprocessable_entity }
    #     format.json
    #   end
    # end
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.save!
    redirect_to post_path(@post)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.draft = false
    @post.update
  end

  def publish
    @post = Post.find(params[:id])
    @post.draft = false
    @post.save
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_drafts_path
  end

  def drafts
    @drafts = Post.all.select do |post|
      post.draft
    end
  end

  def historique
    @historique = Post.all.select do |post|
      post.draft == false
    end
  end

  private

  def post_params
    params.require(:post).permit(:prompt, photos: [])
  end
end
