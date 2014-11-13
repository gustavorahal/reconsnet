ReconsNet::Application.routes.draw do

  root to: 'application#index'

  devise_for :users, :controllers => { :registrations => 'registrations' }

  get 'marketing', to: 'marketing#index'
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
    resources :participations do
      collection do
        get 'emails'
      end
    end
  end
  resources :tmks
  resources :volunteers
  resources :assets
  resources :activities
  get 'versions', to: 'versions#index'

end
