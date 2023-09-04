class ProgrammationsController < ApplicationController
  def index
    @programmation = @post.programmation
  end

  def new
    @post = Post.find(params[:post_id])
    @programmation = Programmation.new
  end

  def show
    @post = Post.find(params[:post_id])
    @programmation = Programmation.find(params[:id])
  end

  def create
    @programmation = Programmation.new(programmation_params)
    @post = Post.find(params[:post_id])
    @programmation.post = @post
    if @programmation.save!
      redirect_to post_programmation_path(@post, @programmation)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @programmation = Programmation.find(params[:id])
  end

  def update
    @programmation = Programmation.find(params[:id])
    @post = @programmation.post
    @programmation.update!(programmation_params)
    if @programmation.save
      redirect_to post_programmations_path(@post)
    else
      render 'post/show', status: :unprocessable_entity
    end
  end

  def destroy
    @programmation = Programmation.find(params[:id])
    @programmation.destroy
    redirect_to programmations_path
  end

  private

  def programmation_params
    params.require(:programmation).permit(:open_at, :close_at)
  end

end
