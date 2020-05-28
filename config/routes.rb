Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  
  resources :colors,     only: [:show] do
    member do
      get 'order/:param/:order', to: 'colors#order', as: "order"
    end
  end
      
  resources :hero_types, only: [:show] do
    member do
      get 'order/:param/:order', to: 'hero_types#order', as: "order"
    end
  end
  
  resources :heros,      only: [:show] do
    member do
      get 'order/:param/:order', to: 'heros#order', as: "order"
    end
  end
  
  resources :ssrs,       only: [:index, :edit, :update, :show] do
    collection do
      get 'order/:param/:order', to: 'ssrs#order', as: "order"
    end
  end
end
