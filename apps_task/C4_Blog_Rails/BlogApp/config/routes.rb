BlogApp::Application.routes.draw do
 
  get "home/index"

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'createblog', to: 'blogs#new' , as: 'createblog'

  resources :users
  resources :sessions
  resources :blogs
  resources :posts do
              resources :comments
            end
  root to: 'home#index'

end
