Rails.application.routes.draw do
  get 'programmations/index'
  get 'programmations/show'
  # get 'programmations/new'
  # get 'programmations/create'
  # get 'programmations/update'
  # get 'programmations/edit'
  # get 'programmations/destroy'
  # get 'posts/index'
  # get 'posts/show'
  # get 'posts/new'
  # get 'posts/create'
  # get 'posts/edit'
  # get 'posts/update'
  # get 'posts/destroy'
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
    resources :programmations, only: [:show, :create, :new]
  end

  resources :programmations, only: [:edit, :update, :index]

  get 'drafts', to: 'posts#drafts', as: 'posts/drafts'
  get 'historique', to: 'posts#historique', as: 'posts/historique'
  get 'publish/:id', to: 'posts#publish', as: 'posts/publish'
  patch 'regenerate/:id', to: 'posts#regenerate', as: "regenerate"
end
