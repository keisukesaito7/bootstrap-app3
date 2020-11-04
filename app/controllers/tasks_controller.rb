class TasksController < ApplicationController
  before_action :redirect_to_root_path, only: :index
  before_action :set_current_user, only: :index

  def index
    @tasks = Task.all.order('created_at DESC')
  end

  private
  def redirect_to_root_path
    redirect_to root_path unless user_signed_in?
  end

  def set_current_user
    @user = User.find(current_user.id)
  end

  def task_params
    params.require(:task).permit(:content)
  end
end
