Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  resources :colors,     only: [:show]
  resources :hero_types, only: [:show]
  resources :heros,      only: [:show] do
    member do
      get :spatk_desc, :atk_desc
      get 'order/:param/:order', to: 'heros#order', as: "order"
    end
  end
  resources :ssrs,       only: [:index]
end
