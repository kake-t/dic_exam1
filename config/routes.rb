Rails.application.routes.draw do
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  resources :contacts
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
