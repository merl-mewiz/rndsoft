class UsersController < ApplicationController
    def profile
    end

    def user_update_mailing
        if current_user.update(user_params)
            flash[:notice] = "Данные подписки успешно обновлены"
            redirect_to user_root_path
        else
            flash[:alert] = "Ошибка при обновлении данных подписки"
            redirect_to user_root_path
        end
    end

    private
        def user_params
            params.require(:user).permit(:mail_digest)
        end
end