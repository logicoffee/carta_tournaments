Rails.application.routes.draw do
  root 'static_pages#home'
  get :info, to: 'static_pages#info'

  resource :team, except: %i[new create destroy] do
    resources :players, only: %i[new create destroy]
  end
  get  :sign_up, to: 'teams#new'
  post :sign_up, to: 'teams#create'

  get    :sign_in, to: 'sessions#new'
  post   :sign_in, to: 'sessions#create'
  delete :sign_out, to: 'sessions#destroy'

  get 'account_activation/:id', to: 'account_activations#activate', as: :account_activation
end
