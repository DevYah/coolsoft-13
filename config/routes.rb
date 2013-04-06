Sprint0::Application.routes.draw do
  match '/users/expertise' => 'users#expertise'
  match '/users/new_committee_tag' => 'users#new_committee_tag'
  match '/home/index' => 'home#index'
  match '/users/change_settings' => 'users#change_settings'

  #get "ideas/new"
  resources :ideas




  default_url_options :host => "localhost:3000"
  devise_for :users, :controllers => { :registrations => "registrations" }



  devise_for :committees, :controllers => { :registrations => "registrations" }


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



  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end
  root:to => 'home#index'
  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
 #root :to => 'ideas#show'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'


  match "/review_ideas" => "committees#review_ideas"
    

  match '/users/confirm_deactivate' => 'users#confirm_deactivate'
  match '/users/deactivate' => 'users#deactivate'


end
