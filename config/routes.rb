Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :delivery_pages, only: :show
  resources :aquas, only: :show do
    resources :volumes, only: :index
    collection do 
      get 'check_price' => 'aquas#check_price'
    end
  end
  resources :prices, only: :index
  resources :coolers, only: [:index, :show] do
    collection do
      get 'get_image'
    end
  end
  resources :pomps, only: :index
  resources :accessories, only: :index
  resources :phone_calls, only: :create
  resources :services, only: :create
  resources :orders, only: :create
  resources :products, only: :index
  get 'profile' => 'welcome#profile'
  get 'profile/orders' => 'welcome#orders'
  get 'contacts' => 'welcome#contacts'
  get 'delivery' => 'welcome#delivery'
  get 'check_time' => 'welcome#check_time'
  get 'payment' => 'welcome#payment'
  get 'about' => 'welcome#about'
  get 'events' => 'welcome#events'
  get 'events/show/:id' => 'welcome#events_show', as: 'events/show'
  get 'service' => 'welcome#service'

  # 301 redirects
  get '/country',              to: redirect('/delivery_pages/4-Доставка%20питьевой%20воды%20в%20Ленобласти', status: 301)
  get '/cat/coolers',          to: redirect('/coolers', status: 301)
  get '/cat/accessories',      to: redirect('/accessories', status: 301)
  get '/Peterburg',            to: redirect('/delivery_pages/5-Доставка%20воды%20в%20Санкт-Петербурге', status: 301)
  get '/voda-v-ofis',          to: redirect('/delivery_pages/2-Доставка%20воды%20в%20офис', status: 301)
  get '/schedule',             to: redirect('/delivery', status: 301)
  get '/skidki',               to: redirect('/events', status: 301)
  get '/dostavka',             to: redirect('/', status: 301)
  get '/cat/related_items',    to: redirect('/products/cups', status: 301)
  get '/voda-na-dom',          to: redirect('/delivery_pages/1-Доставка%20воды%20на%20дом', status: 301)
  get '/price',                to: redirect('/prices', status: 301)
  get '/usloviya-dostavki',    to: redirect('/delivery', status: 301)
  get '/production',           to: redirect('/', status: 301)
  get '/schools',              to: redirect('/delivery_pages/3-Доставка%20воды%20в%20школы%20и%20детские%20сады', status: 301)
  get '/o-vode/prima-aqua',    to: redirect('/aquas/1', status: 301)
  get '/o-vode/jodis',         to: redirect('/aquas/4', status: 301)
  get '/primaaqua',            to: redirect('/aquas/1', status: 301)
  get '/zakaz-dostavka-vody',  to: redirect('/', status: 301)
  get '/o-vode/legenda-gor',   to: redirect('/aquas/2', status: 301)

  root 'welcome#home'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get '*path' => redirect('/')  unless Rails.env.development?
end
