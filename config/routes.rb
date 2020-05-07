Rails.application.routes.draw do
  get 'colors/show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'ssrs#index'
  resources :colors,     only: [:show]
  resources :hero_types, only: [:show]
  resources :heros,      only: [:show]
  resources :ssrs,       only: [:index]
end
