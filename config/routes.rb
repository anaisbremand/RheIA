Rails.application.routes.draw do

  devise_for :users

  devise_scope :user do
    authenticated :user do
      root 'posts#new', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :posts do
    # resources :programmations, only: [:show, :create, :new]
  end

  # resources :programmations, only: [:edit, :update, :index]

  get 'programmations', to: 'posts#programs', as: 'posts/programs'
  get 'drafts', to: 'posts#drafts', as: 'posts/drafts'
  get 'historique', to: 'posts#historique', as: 'posts/historique'
  get 'publish/:id', to: 'posts#publish', as: 'posts/publish'
  patch 'regenerate/:id', to: 'posts#regenerate', as: "regenerate"
  # get 'programmation/:id', to: 'posts#programmation', as: 'posts/programmation'

  get 'post/:id/programmation', to: 'posts#edit', as: 'post/edit'
  patch 'post/:id/programmation', to: 'posts#programmation', as: 'programme_post'
end
