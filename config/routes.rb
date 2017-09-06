Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'matches#show'
  resources :sketches,  only: [:create]
  resources :matches, only: [:create, :update, :show]

  mount ActionCable.server => '/cable'
end
