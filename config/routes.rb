Rails.application.routes.draw do
  root 'static_pages#home'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  
  
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
  
  get '/heros/allupdate', to: 'heros#allupdate'
  resources :heros do
    member do
      get 'order/:param/:order', to: 'heros#order', as: "order"
      
    end
  end
  
  resources :ssrs do
    collection do
      get 'order/:param/:order', to: 'ssrs#order', as: "order"
    end
  end
  

  resources :users
end
