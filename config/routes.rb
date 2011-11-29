DevconApp::Application.routes.draw do
  get "pages/home"
  get "forecastrequests/new"

  resources :forecastrequests
  
  match '/forecast', :to => 'forecastrequests#new'
  match '/', :to => 'pages#home'
  root :to => 'pages#home'

end
