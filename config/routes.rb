ReconsNet::Application.routes.draw do

  root to: 'application#index'

  devise_for :users, :controllers => { :registrations => 'registrations' }
  require 'sidekiq/web'
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  get 'marketing', to: 'marketing#index'
  get 'inventoriology', to: 'inventoriology#index'
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
      put 'archive'
      put 'unarchive'
    end
    resources :participations
  end
  resources :tmks
  resources :volunteers
  resources :assets
  resources :activities
  get 'versions', to: 'versions#index'

end
