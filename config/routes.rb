Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # map sessions to actions to login and logout
  root 'welcome#index'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  resources :users
  get '/profile' => 'users#profile'
  resources :shows
end
