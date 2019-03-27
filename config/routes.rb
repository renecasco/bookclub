Rails.application.routes.draw do
  resources :books, only: [:index, :show, :new, :create, :destroy] do
    resources :reviews, only: [:index, :new, :create]
  end
  resources :users, only: [:show]
  resources :reviews, only:[:destroy]
  resources :authors, only:[:show, :destroy]
end
