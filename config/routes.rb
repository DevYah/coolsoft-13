Sprint0::Application.routes.draw do
  #match '/home/index' => 'home#index'
  get "home/index"
  get 'Search', to: 'home#show', as: 'Search'
  resources :home
  resources :ideas
  root :to => 'home#index'
end
