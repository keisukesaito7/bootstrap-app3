class TasksController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.valid?
      @task.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def task_params
    params.require(:task).permit(:content).merge(user_id: current_user.id)
  end
end
