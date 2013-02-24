class RequestsController < ApplicationController

  before_filter :authenticate_user!

  def index
    user = current_user

    @requests = user.requests
  end

  def approve
    user = current_user
    @request = user.requests.where(:id => params[:id] ).first

    unless @request.nil?
      @request.delete

      user.approved_providers << @request.provider.id
      user.save

    end
    redirect_to dashboard_path(:auth_token => user.authentication_token)
  end

  def ignore
    user = current_user
    @request = user.requests.where(:id => params[:id] )

    unless @request.nil?
      @request.delete
      user.save
    end

    @request.delete
    user.save

    redirect_to dashboard_path(:auth_token => user.authentication_token)
  end
end
