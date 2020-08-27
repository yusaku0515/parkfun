Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    registrations: 'users/registrations',
    passwords:     'users/passwords',
  }

  resources :users, only: [:show, :edit, :update]
  get 'users/:id/leave' => 'users#leave', as: 'users_leave'

  resources :posts do
    # いいね
    resources :likes, only: [:create, :destroy]

    # コメント
    resources :comments, only: [:create, :destroy]
  end
  # アバウト画面
  get 'home/about' => 'homes#about'
  # トップ画面
  get 'home/top' => 'homes#top'

  # お問い合わせ画面
  get 'contacts/new'
  post 'contacts/create'

  # 検索画面
  get  'search' => 'searches#search',  as: 'search'

  # トップ画面
  get '/' => 'homes#top', as: 'root'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
