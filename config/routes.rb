Rails.application.routes.draw do
  # root 'welcome#index'

  # resources :books, only: [:index, :show, :new, :create, :destroy] do
  #   resources :reviews, only: [:new, :create]
  # end
  resources :users, only: [:show]
  # resources :reviews, only:[:destroy]
  # resources :authors, only:[:show, :destroy]

  get '/', to: 'welcome#index', as: :root

  get '/books', to: 'books#index'
  post '/books', to: 'books#create'
  get '/books/new', to: 'books#new', as: :new_book
  get '/books/:id', to: 'books#show', as: :book
  delete '/books/:id', to: 'books#destroy'

  get '/books/:book_id/reviews/new', to: 'reviews#new', as: :new_book_review
  get '/books/:book_id/reviews', to: 'reviews#index', as: :book_reviews
  post '/books/:book_id/reviews', to: 'reviews#create'
  delete '/reviews/:id', to: 'reviews#destroy', as: :review

  get '/authors/:id', to: 'authors#show', as: :author
  delete '/authors/:id', to: 'authors#destroy'
end
