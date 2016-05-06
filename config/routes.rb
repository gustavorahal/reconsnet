ReconsNet::Application.routes.draw do

  root to: 'application#index'

  devise_for :users, :controllers => { :registrations => 'registrations' }
  require 'sidekiq/web'
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  get 'marketing', to: 'marketing#index'
  get 'inventoriology', to: 'inventoriology#index'
  post 'inventoriology', to: 'inventoriology#create'
  get 'about', to: 'application#about'
  post '/tinymce_assets' => 'tinymce_assets#create'

  resources :people do
    member do
      get 'versions'
    end
  end
  resources :users
  resources :events do
    collection do
      get 'calendar'
    end
    member do
      get 'attendance'
      get 'emails'
      get 'roles'
      get 'versions'
      put 'archive'
      put 'unarchive'
    end
    resources :participations do
      member do
        put 'record_attendance'
      end
    end
  end
  resources :tmks
  resources :volunteers
  resources :assets
  resources :activities do
    member do
      get 'versions'
    end
  end
  get 'versions', to: 'versions#index'

  # Help
  get 'help' => 'help#index'
  get ':controller/:action/', controller: 'help'

end
