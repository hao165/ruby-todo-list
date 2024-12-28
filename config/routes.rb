Rails.application.routes.draw do
  # API 路由
  namespace :api do
    post 'login', to: 'authentication#login'
    resources :todos, only: [:index, :create, :update, :destroy]
  end

  # 模板頁面路由
  root to: 'pages#home'

  # 登入頁面
  get 'auth/login', to: 'pages#auth', as: 'login'
end
