ActionController::Routing::Routes.draw do |map|
  map.resources :ins_stores

  map.resources :stores_in_groups

  map.resources :store_groups

  map.resources :stores

  map.resources :logins

  map.resources :user_result_assignments

  map.resources :runner_categories

  map.resources :invitations

  map.resources :invitation_inputs

  map.resources :emails

  map.resources :responses

  map.resources :gp_datas

  map.resources :grandprixes

  map.resources :camp_units

  map.resources :camp_pics

  map.resources :campaigns

  map.resources :diploma_elements

  map.resources :diploma_schemas

  map.resources :friend_requests

  map.resources :friendrelations

  map.resources :wallevents

  map.resources :payment_notifications

  map.resources :payconds

  map.resources :runevents

  map.resources :inscriptions

  map.resources :userpictureassignments

  map.resources :picturecomments

  map.resources :pictures

  map.resources :uservideoassignments

  map.resources :videocomments

  map.resources :videos

  map.resources :results

  map.resources :convocatoriaunits

  map.resources :links

  map.resources :runtypes

  map.resources :runs

  map.resources :events

  map.resources :organizators

  map.signup  '/signup', :controller => 'users',   :action => 'new'
  map.login  '/login',  :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil

  map.resources :users

  map.resource :session

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "home"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.

  map.connect ':controller/:action'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
