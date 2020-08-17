Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    passwords: "users/passwords",
  }

  resources :users, only: [:show, :edit, :update]
  get 'users/:id/leave' => 'users#leave', as: 'users_leave'

  resources :posts do
    # いいね
    resources :likes, only: [:create, :destroy]

    # コメント
    resources :comments, only: [:create, :destroy]
  end

  get 'home/about' => 'homes#about'
  get 'home/top' => 'homes#top'

  # 検索画面
  get  'search' => 'searches#search',  as: 'search'

  # トップ画面
  get '/' => 'homes#top', as: 'root'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
