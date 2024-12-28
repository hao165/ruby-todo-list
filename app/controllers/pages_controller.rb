class PagesController < ApplicationController
  def home
    @todos = Todo.all
  end
end
