Rails.application.routes.draw do
  # API 路由
  namespace :api do
    resources :todos, only: [:index, :create, :update, :destroy]
  end
end
