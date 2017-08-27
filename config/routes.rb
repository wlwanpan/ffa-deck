Rails.application.routes.draw do
  # resources :accounts
  # scope :format => true, :constraints => { :format => 'json' } do
  #   post   "/login"       => "session#create"
  #   delete "/logout"      => "session#destroy"
  # end
  resources :users
end
