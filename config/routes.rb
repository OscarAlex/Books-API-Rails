Rails.application.routes.draw do
  #Created with rails g controller...
  #get 'books/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  #api/v1/books
  namespace :api do
    namespace :v1 do
      resources :books, only: [:index, :create, :destroy]

      post 'authenticate', to: 'authentication#create'
    end
  end
end
