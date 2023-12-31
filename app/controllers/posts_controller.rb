require 'rest-client'
require 'json'
require 'open-uri'

class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update publish destroy regenerate programmation]

  def new
    @post = Post.new
  end

  def show
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.valid?
      @post.description = description_from(ask_chatgpt(@post.prompt))
      array_img = ask_dalle(ask_chatgpt(@post.prompt), @post.many_imgs)
    end
    if @post.save
      create_pictures
      array_img.each do |img|
        @post.pictures.create(photo: URI.open(img['url']))
      end
      redirect_to post_path(@post)
    else
      # Gestion des erreurs, par exemple réafficher le formulaire
      render :new
    end
  end

  def edit
  end

  def update
    new_description = params[:post][:description]
    @post.description = new_description
    if @post.save
      redirect_to post_path(@post)
    else
      render 'posts/show', status: :unprocessable_entity
    end
  end

  def publish
    @post.update(draft: false, program: nil)
  end

  def destroy
    @post.destroy
    redirect_to posts_drafts_path
  end

  def drafts
    @drafts = Post.where(draft: true).order('created_at DESC')
  end

  def historique
    @historique = Post.where(draft: false).order('created_at DESC')
  end

  def programs
    @programmations = Post.where.not(program: nil).order(program: :asc)
  end

  def regenerate
    @post.description = description_from(ask_chatgpt(@post.prompt))
    redirect_to post_path(@post) if @post.save
  end

  def programmation
    @post.update(program: params[:post][:program])
    if @post.save
      redirect_to posts_programs_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:prompt, :description, :many_imgs)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def create_pictures
    photos = params.dig(:post, :pictures)
    photos.reject!(&:blank?)
    photos.each do |photo|
      @post.pictures.create(photo: photo)
    end
  end

  def better_prompt(prompt)
    return "Réalise les étapes suivante:
    1. voici mon thème : '#{prompt}'
    2. crée une description en FRANCAIS de 300 caractères maximum d'un post Instagram et tu la mets entre crochets [].
    3. écris une instruction en 100 caractères, en ANGLAIS à donner à une IA génératrice d'images
    à partir de la description que tu as inventée juste avant qui doit l'illustrer et tu la mets entre accolades { }."
  end

  def ask_chatgpt(prompt)
    url = "https://api.openai.com/v1/chat/completions"
    payload = { model: "gpt-3.5-turbo", messages: [{ role: "user", content: better_prompt(prompt) }] }.to_json
    headers = { Authorization: "Bearer #{ENV.fetch('OPENAI_TOKEN')}", 'Content-Type': 'application/json' }
    response = RestClient.post(url, payload, headers)
    reponse_gpt = JSON.parse(response.body)
    return reponse_gpt['choices'][0]['message']['content']
  end

  def description_from(reponse_gpt)
    return reponse_gpt.match(/\[(.*?)\]/)[1]
  end

  def img_from(reponse_gpt)
    return reponse_gpt.match(/\{(.*?)\}/)[1]
  end

  def ask_dalle(prompt, many_imgs)
    url = "https://api.openai.com/v1/images/generations"
    payload = { prompt: img_from(prompt), n: many_imgs, size: "512x512" }.to_json
    headers = { Authorization: "Bearer #{ENV.fetch('OPENAI_TOKEN')}", 'Content-Type': 'application/json' }
    response = RestClient.post(url, payload, headers)
    reponse_dalle = JSON.parse(response.body)
    return reponse_dalle['data']
  end
end
