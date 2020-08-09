Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:show, :edit, :update]
  get 'users/:id/leave' => 'users#leave', as: 'users_leave'


  get 'home/about' => 'homes#about'
  get 'home/top' => 'homes#top'

     # エンドユーザー側のトップ画面
   get '/' => 'users/homes#top', as: 'root'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
