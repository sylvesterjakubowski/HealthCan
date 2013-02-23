class RequestsController < ApplicationController

  before_filter :authenticate_user!

  def index
    user = current_user

    @requests = user.requests
  end

  def approve
    user = current_user
    @request = user.requests.where(:id => params[:id] ).first

    user.approved_providers << @request.provider.id
    user.save

    redirect_to dashboard_path

  end

  def ignore
    user = current_user
    @request = user.requests.where(:id => params[:id] )

    @request.delete
    user.save

    redirect_to dashboard_path
  end
end
