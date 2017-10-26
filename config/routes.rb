Rails.application.routes.draw do

  get '/',to: 'home#show'

  get    'backstage',   to: 'backstage#new'
  resources :users, path: "backstage/users"
  resources :users, :only => [:index, :show]

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get '/signup', to: 'users#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
