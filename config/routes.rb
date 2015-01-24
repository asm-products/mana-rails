Rails.application.routes.draw do
  
  root to: "home#index"
  
  # Custom routes
  get 'signup', to: "users#new"
  get 'login', to: "sessions#new"
  post 'login', to: "sessions#create"
  delete 'logout', to: 'sessions#destroy'
  get 'users/:id/profile', to: 'users#edit_profile', as: 'edit_users_profile'
  put 'users/:id/profile', to: 'users#update_profile', as: 'user_profile'
  patch 'users/:id/profile', to: 'users#update_profile'
  
  # Resources
  resources :users
  get 'users/verify/:id', to: 'users#verify', as: 'user_verify'
  get 'users/reverify/:id', to: 'users#reverify', as: 'user_reverify'

  resources :teams
  resources :projects
  resources :clients do
    get 'contacts/verify/:id', to: 'contacts#verify', as: 'contact_verify'
    patch 'contacts/verify/:id', to: 'contacts#verified'
    get 'contacts/reverify/:id', to: 'contacts#reverify', as: 'contact_reverify'
    resources :contacts
    resources :comments
  end
  resources :contacts do
    resources :comments
  end
  
  ## API routes
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :clients do
        resources :contacts
      end
      resources :projects do
        resources :issues
      end
      resources :users
    end
  end
end
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
