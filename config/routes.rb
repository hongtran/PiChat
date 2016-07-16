Rails.application.routes.draw do
  get 'friendship/create'

  get 'friendship/destroy'

  resources :sessions, only: [:new, :create]
  resources :users do
  	resources :messages
  end
  delete '/logout' => 'sessions#destroy'
  get '/message/show' =>'messages#show'
  get '/show' => 'users#show'
  get '/sent' => 'users#sent'
  get '/alluser'	=> 'users#all_user'
  root "users#index"
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
