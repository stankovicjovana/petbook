Rails.application.routes.draw do
  resources :posts
  resources :photos
  resources :pets
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  resources :users
  root 'welcome#index', as: 'welcome_index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
