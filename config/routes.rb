MusicApp::Application.routes.draw do
  resources :users, only: [:show]

  get "register" => "users#new"
  post "register" => "users#create"

  get "login" => "session#new"
  post "login" => "session#create"
  delete "logout" => "session#destroy"
end
