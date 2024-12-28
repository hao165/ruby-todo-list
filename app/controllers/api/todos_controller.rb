module Api
  class TodosController < ApplicationController
    include Current
    before_action :authenticate_user
    before_action :set_todo, only: [:show, :update, :destroy]

    # GET /api/todos
    def index
      @todos = @current_user.todos
      render json: @todos, status: :ok
    end

    # POST /api/todos
    def create
      @todo = @current_user.todos.new(todo_params)
      if @todo.save
        render json: @todo, status: :created
      else
        render json: @todo.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /api/todos/1
    def update
      if @todo.update(todo_params)
        render json: @todo, status: :ok
      else
        render json: @todo.errors, status: :unprocessable_entity
      end
    end

    # DELETE /api/todos/1
    def destroy
      @todo.destroy
      head :no_content
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = @current_user.todos.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def todo_params
      params.require(:todo).permit(:title, :completed)
    end

    # Validate the current
    def authenticate_user
      render json: { error: 'Not authorized' }, status: :unauthorized if @current_user.nil?
    end
  end
end
