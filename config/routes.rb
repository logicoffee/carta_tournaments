Rails.application.routes.draw do
  root 'static_pages#home'
  get :info, to: 'static_pages#info'

  resource :team, except: %i[new create destroy]
  get  :sign_up, to: 'teams#new'
  post :sign_up, to: 'teams#create'

  get    :sign_in, to: 'sessions#new'
  post   :sign_in, to: 'sessions#create'
  delete :sign_out, to: 'sessions#destroy'
end
