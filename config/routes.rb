ReconsNet::Application.routes.draw do

  devise_for :users, :controllers => { :registrations => 'registrations' }

  root to: 'tasks#index'

  get 'tasks', to: 'tasks#index'

  get 'divulgacao', to: 'divulgacao#index'

  resources :people
  resources :users
  resources :events do
    resources :participations do
      collection do
        get 'emails'
      end
    end

  end

end
