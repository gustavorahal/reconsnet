Recons::Application.routes.draw do

  root 'tarefas#index'

  post '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#failure'
  get '/logout', to: 'sessions#destroy'
  get '/login', to: 'sessions#new'

  resources :identities
  resources :usuarios
  
  
  #get 'logout' => 'application#logout', :as => :logout
  #get 'login' => 'application#login', :as => :login
  #post 'login' => 'application#post_login', :as => :post_login

  get 'tarefas', to: 'tarefas#index'

  get 'divulgacao', to: 'divulgacao#index'

  resources :pessoas
  resources :eventos do
    resources :participacoes do
      collection do
        get 'emails'
      end
    end

  end

end
