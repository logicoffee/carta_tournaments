Rails.application.routes.draw do
  root 'static_pages#home'
  get :info, to: 'static_pages#info'
end
