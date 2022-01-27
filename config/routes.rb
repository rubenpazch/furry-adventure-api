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
    namespace :users do 
      namespace :v1 do 
        resources :registration, only: [:create]
      end
    end
    namespace :jobs do 
      namespace :v1 do 
        resources :jobs, only: [:index]
      end
    end
  end
end
