Rails.application.routes.draw do
  
  root to: "tasks#index"
 
  
  #userコントローラ⇒userモデル
  get "signup", to: "users#new" #サインアップ
  resources :users, only: [:index, :new, :create]
  
  #session（ログイン情報保持、ステートフル)関連 モデルはなし。
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
   resources :tasks
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
