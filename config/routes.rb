Rails.application.routes.draw do
  # get 'posts/index'
  # get 'posts/show'
  # get 'posts/new'
  # get 'posts/create'
  # get 'posts/edit'
  # get 'posts/update'
  # get 'posts/destroy'
  devise_for :users
  root to: "posts#new"

  resources :posts
  get 'drafts', to:'posts#drafts', as:'posts/drafts'
  get 'historique', to:'posts#historique', as:'posts/historique'
  get 'publish/:id', to:'posts#publish', as:'posts/publish'
end
