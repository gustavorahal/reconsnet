ReconsNet::Application.routes.draw do

  root to: 'application#index'

  devise_for :users, :controllers => { :registrations => 'registrations' }

  get 'marketing', to: 'marketing#index'

  resources :people
  resources :users
  resources :events do
    resources :participations do
      collection do
        get 'emails'
      end
    end
  end
  resources :tmks
  resources :volunteers
  resources :assets

end
