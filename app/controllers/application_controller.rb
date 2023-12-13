class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
  
    def not_found
      # render file: "#{Rails.root}/app/views/errors/404.html", layout: false, status: :not_found
      render file: Rails.root.join('public', '404.html'), status: :not_found
    end

    def forbidden
      # render file: "#{Rails.root}/app/views/errors/403.html", layout: false, status: :forbidden
      render file: Rails.root.join('public', '403.html'), status: :forbidden
    end

    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username])
    end
  end
  