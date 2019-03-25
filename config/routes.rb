Rails.application.routes.draw do
  resources :books, only: [:index, :show, :new, :create] do
    resources :reviews, only: [:index, :new, :create]
  end
  resources :users, only: [:show]
  resources :reviews, only:[:destroy]
end
