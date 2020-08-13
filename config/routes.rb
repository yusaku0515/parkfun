Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    passwords: "users/passwords",
  }

  resources :users, only: [:show, :edit, :update]
  get 'users/:id/leave' => 'users#leave', as: 'users_leave'

  resources :posts

  get 'home/about' => 'homes#about'
  get 'home/top' => 'homes#top'

  # トップ画面
  get '/' => 'homes#top', as: 'root'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
