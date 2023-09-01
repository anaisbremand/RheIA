class ProgrammationsController < ApplicationController
  def index
    @programmations = Programmation.all
  end

  def new
    @post = Post.find(params[:post_id])
    @programmation = Programmation.new
  end

  def show
    @programmation = Programmation.find(params[:id])
  end

  # def create
  #   @programmation = Programmation.new(programmation_params)
  #   @post = Post.find(params[:post_id])
  #   @programmation.post = @post
  #   if @programmation.save!
  #     redirect_to post_path(@post)
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end

  def edit
    @programmation = Programmation.find(params[:id])
  end

  def update
    @programmation = Programmation.find(params[:id])
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
