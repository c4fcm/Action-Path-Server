Rails.application.routes.draw do

  devise_for :users
  
  # some endpoints used by the app client
  get 'issues/near' => 'issues#near'
  get 'places/near' => 'places#near'
  post 'logs/sync' => 'logs#sync'
  post 'installs/add' => 'installs#add'
  post 'responses/sync' => 'responses#sync'
  get 'responses/on_issues' => 'responses#on_issues'
  get 'stats/stats_by_request_type' => 'stats#stats_by_request_type'
  get 'stats/notification_paths' => 'stats#notification_paths'
  get 'responses/map' => 'responses#map'

  resources :users, :responses, :subscriptions, :logs
  
  resources :issues do 
    resources :responses
    resources :logs
  end

  resources :places do
    resources :issues
  end

  resources :installs do
    resources :subscriptions
    resources :logs
    resources :responses
  end

  root to: "places#index"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
