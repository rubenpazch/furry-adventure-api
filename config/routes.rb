Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [:show, :create, :update, :destroy]
      resources :login, only: [:create]
      get "tokens", to: "tokens#verify"
      post "menu", to: "menu#menusubmenu"
      #get "users", to: "users#admins"
      #resources :menu, only: [:index]
    end
  end

  #namespace :api, default: { format: :json } do
  #  namespace :v1 do
  #    namespace :users do
  #      resources :registration, only: [:create]
  #    end
  #    resources :jobs, only: [:index]
  #    namespace :products do
  #      resources :categories, only: [:index]
  #    end
  #    resources :products, only: [:index, :show, :create, :update]
  #  end
  #end
end
