Rails.application.routes.draw do

  root "items#index"
  resources :items
    resources :comments

  resource :purchase

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  resource :items, only: [:show]
  root "top#index"
  get "logout/index"
  get "items/purchase"
  # items/purchaseは画面を表示するための仮置きです
  resources :user, only:[:index, :edit, :destroy]
  resources :card, only: [:new, :show, :destroy] do
    collection do
      post 'show', to: 'card#showing'
      post 'pay', to: 'card#pay'
    end
  end

  #住所登録をウィザード形式で表示させる
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end

end