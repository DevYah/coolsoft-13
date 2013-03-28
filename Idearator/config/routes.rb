Sprint0::Application.routes.draw do

  #match '/home/index' => 'home#index'
  get "home/index"
  get 'Search', to: 'home#show', as: 'Search'
  resources :home
  resources :ideas
  root :to => 'home#index'
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products



end
