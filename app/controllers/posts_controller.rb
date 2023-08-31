require 'rest-client'
require 'json'

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
    @post.description = chat_with_gpt(@post.prompt)
    # chat_with_dalle(chat_with_gpt(@post.prompt))
    if @post.save
      redirect_to post_path(@post)
    else
      # Gestion des erreurs, par exemple réafficher le formulaire
      render json: { errors: @post.errors.full_messages }, status: 422
    end
  end

  # def passerelle
  #   @post = Post.find(params[:id])
  #   # @post.description = params[:description]
  #   # @post.save
  # end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
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

  def good_prompt(prompt)
    better_prompt = "Réalise les étapes suivante:
    1. écris une description en maximum 300 caractères de post Instagram sur le thème : '#{prompt}' et respecte ces conditions:
    a) La description doit être en FRANCAIS.
    b) TOUTE La description issue de mon thème doit être entre crochet [] pour la récupérer avec un regexp.
    2. écris une instruction à donner à une IA génératrice d'images à partir de la description que tu as inventée juste avant. Elle doit illustrer le thème et permettre une création d'images en rapport avec.
    L'instruction doit respecter les conditions suivantes:
        a) Sans limite de caractère.
        b) elle doit être détaillée.
        c) elle doit être en anglais.
        d) contenir les mots 'Ultra realistic photo'.
        e) TOUTE l'instruction doit être entre accolades { } afin d'être envoyée directement à l'IA génératrice d'image"
    return better_prompt
  end

  def create_description(reponse_gpt)
    description = reponse_gpt.match(/\[(.*?)\]/)
    if description
      return description[1]
    end
  end

  def create_img(reponse_gpt)
    description = reponse_gpt.match(/\{(.*?)\}/)
    if description
      return description[1]
    end
  end

  def chat_with_gpt(prompt)
    api_key = ENV['CHATGPT']
    url = "https://api.openai.com/v1/chat/completions"

    headers = { Authorization: "Bearer #{api_key}", 'Content-Type': 'application/json' }

    payload = { model: "gpt-3.5-turbo", messages: [{ role: "user", content: good_prompt(prompt) }] }.to_json
    response = RestClient.post(url, payload, headers)
    parsed_response = JSON.parse(response.body)

    reponse_gpt = parsed_response['choices'][0]['message']['content']
    return reponse_gpt
  end

  # def chat_with_dalle(prompt)
  #   api_key = ENV['CHATGPT']
  #   url = "https://api.openai.com/v1/images/generations"
  #   headers = { Authorization: "Bearer #{api_key}", 'Content-Type': 'application/json' }
  #   payload = { prompt: create_img(prompt), n: 1, size: "512x512" }.to_json

  #   response = RestClient.post(url, payload, headers)
  #   parsed_response = JSON.parse(response.body)
  #   puts parsed_response
  #   reponse_dalle = parsed_response['data'][0]['url']
  #   return reponse_dalle
  # end
end
