class UserDigestMailer < ApplicationMailer
    default from: 'rails.rnd.test@gmail.com'

    def dw_digest
        @user = params[:user]
        @one_news = params[:message]
        mail_subject = params[:mail_subject]
        mail(to: @user.email, subject: mail_subject)
    end
end
