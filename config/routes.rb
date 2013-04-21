Sprint0::Application.routes.draw do
  match '/users/expertise' => 'users#expertise'
  match '/users/new_committee_tag' => 'users#new_committee_tag'
  match '/home/index' => 'home#index'

 

  get   '/login', :to => 'sessions#new', :as => :login
  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/failure', :to => 'sessions#failure'

  root :to => 'home#index'

  default_url_options :host => 'localhost:3000'
  devise_for :users, :controllers => { :registrations => 'registrations' }

  devise_scope :user do
  match '/users/registrations/twitter_screen_name_clash' => 'registrations#twitter_screen_name_clash'
end
  resources :users do
    member do
      match 'ban_unban' => 'admins#ban_unban'
      match 'approve_committee' => 'users#approve_committee'
      match 'reject_committee' => 'users#reject_committee'
    end

    collection do
      put 'change_settings'
      match 'expertise'
      match 'new_committee_tag'
      match 'confirm_deactivate'
      match 'deactivate'
    end
  end

  resources :ideas do
    match 'filter', on: :collection
  end

  controller :home do
    match 'search'
    match 'index'
  end

  # Admin actions routes
  controller :admins do
    match 'invite'
    match 'invite_committee'
  end


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

  # This is a legacy wild controller route that's not recommended
  # for RESTful applications.
  # Note: This route will make all actions in every controller
  # accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'



end
