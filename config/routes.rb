Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  resources :delivery_pages, only: :show
  resources :aquas, only: :show do
    resources :volumes, only: :index
    collection do 
      get 'check_price' => 'aquas#check_price'
    end
  end
  resources :prices, only: :index
  resources :coolers, only: [:index, :show]
  resources :pomps, only: :index
  resources :accessories, only: :index
  resources :phone_calls, only: :create
  root 'welcome#home'
  get 'contacts' => 'welcome#contacts'
  get 'delivery' => 'welcome#delivery'
  get 'check_time' => 'welcome#check_time'
  get 'payment' => 'welcome#payment'
  get 'about' => 'welcome#about'
  get 'events' => 'welcome#events'
  get 'events/show/:id' => 'welcome#events_show', as: 'events/show'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
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
