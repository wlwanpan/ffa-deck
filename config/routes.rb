Rails.application.routes.draw do

  mount ActionCable.server => '/cable'

  match 'broadcast', to: 'accounts#broadcast', via: [:post]

  resources :accounts, only: [:index, :show, :create] do
    collection do
      post :login, path: "/login"
      post :logout, path: "/logout"  
      post :register, path: "/register"
    end
  end

end