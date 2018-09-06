Rails.application.routes.draw do
  get 'teams/show'
  get 'teams/new'
  get 'teams/edit'
  root 'static_pages#home'
  get :info, to: 'static_pages#info'
end
