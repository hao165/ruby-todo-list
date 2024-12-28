class PagesController < ApplicationController
  def home
    @todos = Todo.all
  end

  def auth
    render 'pages/auth/login'
  end
end
