class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
  	home_path
	end

  rescue_from CanCan::AccessDenied do |exception|
  	redirect_back(fallback_location: root_path, :alert => exception.message)
	end
end
