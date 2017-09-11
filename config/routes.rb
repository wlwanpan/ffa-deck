Rails.application.routes.draw do

  mount ActionCable.server => '/cable'

  resources :accounts, only: [:index, :show, :create] do
    collection do
      post :login, path: "/login"
      post :logout, path: "/logout"      
      post :register, path: "/register"
    end
  end
  
  resources :channels, only: [:index, :create] do
    member do
      post :broadcast, path: "/broadcast"
    end
  end
end