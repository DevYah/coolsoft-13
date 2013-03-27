Sprint0::Application.routes.draw do
  root :to => 'home#index'
  get "ideas/new"
  resources :ideas
  





  
end
