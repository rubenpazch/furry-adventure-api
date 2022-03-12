Rails.application.routes.draw do  
  get 'health/index'
  namespace :api, defaults: { format: :json} do
    namespace :v1 do
      resources :users, only: [:show, :create, :update, :destroy]
      resources :login, only: [:create]
      get 'tokens', to: 'tokens#verify'
      get 'users', to: 'users#admins'
    end
  end

  namespace :api, default: { format: :json} do
    namespace :v1 do 
      namespace :users do 
        resources :registration, only: [:create]
      end
    end
    namespace :v1 do 
      resources :jobs, only: [:index]
    end
    namespace :v1 do 
      resources :products, only: [:index]
    end
    namespace :v1 do 
      namespace :products do 
        resources :categories, only: [:index]
      end
    end 
  end
end
