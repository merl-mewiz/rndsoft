class ApplicationController < ActionController::Base
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

    def check_auth
        unless current_user && current_user.isadmin
            redirect_to root_path
        end
    end
end
