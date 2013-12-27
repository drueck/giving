Giving::Application.routes.draw do

  root to: 'home#index'

  resource :organization, only: [:edit, :update]

  resources :contributors
  resources :batches do
    resources :contributions, controller: "batch_contributions"
  end
  resources :contributions

  resources :users
  resources :sessions

  get 'login' => 'sessions#new', :as => 'login'
  get 'logout' => 'sessions#destroy', :as => 'logout'

  resources :statements, only: [:new, :create]

end
