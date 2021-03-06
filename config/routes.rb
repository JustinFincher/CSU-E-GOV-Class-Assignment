Rails.application.routes.draw do

  get '/',to: 'home#show',as: 'root_url'

  get    'backstage',   to: 'backstage#new'
  resources :users, path: "backstage/users", as: 'backstage_users' do
    resources :documents
  end

  resources :documents, path: "backstage/documents", as: 'backstage_documents'

  resources :users do
    get 'documents/index_hand_over'
    get 'documents/index_reviewed'
    resources :documents,param: :id do
      post 'hand_over_to_upper'
      post 'submit_review_by_upper'
    end
  end

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/signup', to: 'users#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
