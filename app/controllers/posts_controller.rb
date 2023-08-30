class PostsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: '%i :create, :passerrelle'

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to passerelle_post_path(@post), flash: { post_id: @post.id }
    else
      # Gestion des erreurs, par exemple réafficher le formulaire
      render json: { errors: @post.errors.full_messages }, status: 422
    end
  end

  def passerelle
    @post = Post.find(params[:id])
    # @post.description = params[:description]
    # @post.save
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.description = params[:description]
    @post.save
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
    params.require(:post).permit(:prompt, :description, photos: [])
  end
end
