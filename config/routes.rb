Rails.application.routes.draw do
  resources :accounts, only: [:index, :show, :create] do
    collection do
      post "/login" => "accounts#login"
      post "/register" => "accounts#register"
    end
  end
  scope :format => true, :constraints => { :format => 'json' } do
    post   "/login"       => "session#create"
    delete "/logout"      => "session#destroy"
    get    "/test"        => "session#test"
  end
end