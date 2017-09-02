Rails.application.routes.draw do
  resources :accounts, only: [:index, :create] do
    collection do
      post :login, path: "/login"
      post :logout, path: "/logout"      
      post :register, path: "/register"
    end
    member do 
    end
  end
end