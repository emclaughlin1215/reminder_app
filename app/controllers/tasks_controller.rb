class TasksController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @task = User.tasks.new(task_params)
    if @task.save
    else
      # TODO: Send back some sort of error
    end
  end

  def update
    @user = User.find(params[:user_id])
    @task = @user.tasks.find(params[:id])
    if @task.update(task_params)
    else
      # TODO: Send back some sort of error
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @task = @user.tassk.find(params[:id])
    if @task.destroy
    else
      # TODO: Send back some sort of error.
    end
  end

  private
    def task_params
      params.require('task').permit(:title, :description, :repeat, :parent)
    end
end
