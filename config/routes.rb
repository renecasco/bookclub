Rails.application.routes.draw do
  root 'welcome#index'
  resources :books, only: [:index, :show, :new, :create] do
    resources :reviews, only: [:index, :new, :create]
  end
end
