Recons::Application.routes.draw do

  root 'tasks#index'

  get 'tasks', to: 'tasks#index', as: :tasks

  resources :pessoas
  resources :eventos
  resources :evento_pessoas

  #get 'eventos/:evento_id/participacao', to: 'eventos#new_participacao', as: :new_participacao
  #post 'eventos/:evento_id/participacao', to: 'eventos#create_participacao', as: :create_participacao
  #delete 'eventos/:evento_id/participacao/:id', to: 'eventos#destroy_participacao', as: :destroy_participacao

end
