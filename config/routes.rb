Rails.application.routes.draw do

  resources :wikis

  resources :charges, only: [:new, :create]

  put 'charges/change' => 'charges#change'

  devise_for :users, controllers: { registrations: 'registrations' }

  resources :users, only: [:show]

  put 'users/role' => 'users#role'

  get 'about' => 'welcome#about'

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
