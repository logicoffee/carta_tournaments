Rails.application.routes.draw do
  get 'sessions/new'
  root 'static_pages#home'
  get :info, to: 'static_pages#info'

  resource :team, except: %i[new create destroy]
  get  :sign_up, to: 'teams#new'
  post :sign_up, to: 'teams#create'
end
