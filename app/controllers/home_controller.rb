class HomeController < ApplicationController
  before_action :already_signed_in, only: [:top]

  def top
  end

  def test
  end

  private
  def already_signed_in
    if user_signed_in?
      redirect_to test_path
    end
  end
end
