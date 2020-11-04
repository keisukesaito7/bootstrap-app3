class HomeController < ApplicationController
  before_action :set_tasks, if: :user_signed_in?
  
  def top
  end

  def test
  end

  private
  def set_tasks
    @tasks = Task.all.order("created_at DESC")
  end
end
