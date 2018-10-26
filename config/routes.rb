Rails.application.routes.draw do
  root 'static_pages#home'
  get :info, to: 'static_pages#info'

  resource :team, except: %i[new create destroy] do
    get    :entries,      to: 'players#new'
    post   :entries,      to: 'players#create'
    delete 'entries/:id', to: 'players#destroy', as: :delete_entry
  end
  get  :sign_up, to: 'teams#new'
  post :sign_up, to: 'teams#create'

  get    :sign_in, to: 'sessions#new'
  post   :sign_in, to: 'sessions#create'
  delete :sign_out, to: 'sessions#destroy'

  get 'account_activation/:id', to: 'account_activations#activate', as: :account_activation

  namespace :admin do
    root 'players#index'
    get  :sign_in, to: 'sessions#new'
    post :sign_in, to: 'sessions#create'
    delete :sign_out, to: 'sessions#destroy'

    resources 'invitations', only: %i[new create]
    
    get  'sign_up/:id', to: 'members#new',    as: :new_sign_up
    post 'sign_up/:id', to: 'members#create', as: :sign_up
  end
end
