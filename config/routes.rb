BFFGroove::Application.routes.draw do

  # devise
  devise_for :users#, :skip => [:sessions, :registerable]
  # as :user do
  #   get '/users/sign_in' => 'devise/sessions#new', :as => :new_user_session
  #   post '/users/sign_in' => 'devise/sessions#create', :as => :user_session
  #   delete '/users/sign_out' => 'devise/sessions#destroy', :as => :destroy_user_session
  # end
  # get '/users/sign_up' => 'campaign#home'

  # other routes
  root :to => 'campaign#home'
  get '/campaigns' => 'campaign#index'
  get '/campaigns/date' => 'campaign#date'
  get '/campaigns/date?from=:from&to=:to' => 'campaign#date'
  get '/campaigns/graph' => 'campaign#graph'
  get '/group_campaigns/graph' => 'group_campaign#graph'
  get '/group_campaigns'=> 'group_campaign#index'
  get '/group_campaigns/:id' => 'group_campaign#show'
  
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

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
