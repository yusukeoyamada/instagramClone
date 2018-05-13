Rails.application.routes.draw do

  root :to =>'tops#index'

  get "tops/index" => "tops#index"

  resources :contacts

  resources :sessions, only: [:new, :create, :destroy]

  resources :users do
    collection do
        post :confirm
    end
  end

  resources :favorites, only: [:create, :destroy]

  resources :pictures do
      collection do
          post :confirm
      end
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
