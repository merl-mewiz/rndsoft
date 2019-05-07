class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    def blogShowErrors(obj)
        if obj.errors.any?
            errorMsg = "<h4>Ошибки (#{obj.errors.count}):</h4><ul>"
            obj.errors.full_messages.each do |msg|
                errorMsg = errorMsg + "<li>#{msg}</li>"
            end
            errorMsg = errorMsg + "</ul>"
            return errorMsg
        end
    end

    rescue_from CanCan::AccessDenied do |exception|
        redirect_to root_url, alert: exception.message
    end

    protected
        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password)}
            devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username, :email, :password, :current_password)}
        end
end
