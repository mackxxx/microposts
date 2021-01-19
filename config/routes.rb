Rails.application.routes.draw do
 root to: 'toppages#index'
 get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create] do
    member do
      get :followees, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
end