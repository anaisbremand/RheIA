class PostsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

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
    @post.reload
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if params[:from_chat_gpt]
      # Traiter la réponse de ChatGPT et créer un nouveau post
      @post.description = params[:description]
    end
    if @post.save
      render json: { id: @post.id }, status: :created
      redirect_to passerelle_post_path(@post)
    else
      # Gestion des erreurs, par exemple réafficher le formulaire
      render json: { errors: @post.errors.full_messages }, status: 422
    end
  end

  def passerelle
    @post = Post.find(params[:id])
    if params[:from_chat_gpt]
      # Traiter la réponse de ChatGPT et créer un nouveau post
      @post.description = params[:description]
    end
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
    params.require(:post).permit(:prompt, :description, photos: [])
  end
end
