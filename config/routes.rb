Giving::Application.routes.draw do

  root to: 'home#index'

  resource :organization, only: [:edit, :update]

  resources :active_contributors, path: 'contributors'
  resources :posted_contributions, path: 'posted-contributions'
  resources :pending_contributions, path: 'pending-contributions' do
    collection do
      post 'post'
    end
  end
  resources :users
  resources :sessions
  resources :batches

  get 'login' => 'sessions#new', :as => 'login'
  get 'logout' => 'sessions#destroy', :as => 'logout'

  get 'statements' => 'statements#index', as: 'statements'
  post 'statements' => 'statements#show', as: 'statements'

end
