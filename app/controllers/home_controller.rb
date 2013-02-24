class HomeController < ApplicationController
  before_filter :authenticate_user!, :only => [:dashboard]

  def index
    if current_user
      redirect_to dashboard_path
    end

  end

  def dashboard
    sign_in( current_user )
    @user = current_user

  end
end
