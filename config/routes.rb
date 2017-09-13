Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'matches#show'
  resources :sketches,  only: [:create]
  resources :matches, only: [:create, :update, :show]

  post '/matches/turn_end', to: 'matches#turn_end'
  post '/matches/handle_guess', to: 'matches#handle_guess'
  get '/test_api', to:'sketches#test_api'


  mount ActionCable.server => '/cable'
end
