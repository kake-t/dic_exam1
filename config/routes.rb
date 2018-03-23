Rails.application.routes.draw do
  resources :blogs do
    collection do
      post :confirm
    end
  end
  resources :sessions, only: %i[new create destroy]
  resources :users, only: %i[new create show]
  resources :favorites, only: %i[create destroy]
  get '/', to: 'top#index'
end
