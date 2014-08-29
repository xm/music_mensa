MusicApp::Application.routes.draw do
  root to: "artists#index"
  
  resources :users, only: [:show]

  resources :artists do 
    resources :albums, only: [:new]
  end

  resources :albums, except: [:index, :new] do
    resources :tracks, only: [:new]
  end

  resources :tracks, except: [:index, :new] do
    resource :notes, only: [:create]
  end


  get "register" => "users#new"
  post "register" => "users#create"

  get "login" => "session#new"
  post "login" => "session#create"
  delete "logout" => "session#destroy"
end
