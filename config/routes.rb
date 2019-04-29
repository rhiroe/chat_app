Rails.application.routes.draw do
  devise_for :users
  root 'rooms#index'
  resources :rooms, only: %i[new show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
