Rails.application.routes.draw do
  #Created with rails g controller...
  #get 'books/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #get '/books', to 'books#index'
  resources :books, only: [:index, :create]
end
