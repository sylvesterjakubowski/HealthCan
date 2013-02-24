class HomeController < ApplicationController
  before_filter :authenticate_user!, :only => [:dashboard]

  def index
    if user_signed_in?
      redirect_to dashboard_path
    end

  end

  def dashboard
    @user = current_user
    @appointments = @user.appointments

  end
end
