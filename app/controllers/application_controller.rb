class ApplicationController < ActionController::Base

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def self.get_hostname
    if ActionMailer::Base.default_url_options[:port] && ActionMailer::Base.default_url_options[:port].to_s != "80"
      "http://#{ActionMailer::Base.default_url_options[:host]}:#{ActionMailer::Base.default_url_options[:port]}"
    else
      "http://#{ActionMailer::Base.default_url_options[:host]}"
    end
  end

end
