Rails.application.routes.draw do

  mount ActionCable.server => '/cable'

  match 'broadcast', to: 'accounts#broadcast', via: [:post]

  resource :account, only: [:index, :show, :create] do
    post :login, path: "/login"
    post :logout, path: "/logout"
    post :register, path: "/register"

    resources :games
  end

end