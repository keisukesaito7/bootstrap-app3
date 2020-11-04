class TasksController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create]
  before_action :set_current_user, only: [:index, :new, :create]

  def index
    @tasks = Task.all.order('created_at DESC')
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.valid?
      @task.save
      redirect_to tasks_path
    else
      render :new
    end
  end

  private

  def set_current_user
    @user = User.find(current_user.id)
  end

  def task_params
    params.require(:task).permit(:content).merge(user_id: current_user.id)
  end
end
