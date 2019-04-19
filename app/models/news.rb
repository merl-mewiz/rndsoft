class News < ApplicationRecord
    validates :title, :presence => {:message => 'не может быть пустым'}

    # periodicity = 1 - daily
    # periodicity = 2 - weekly
    def self.send_digest(periodicity)
        message = News.where(mail_digest: periodicity, sended: false).order('created_at ASC').first
        if message
            subject = periodicity == 1 ? 'Ежедневный дайджест' : 'Еженедельный дайджест'
            users = User.where(mail_digest: periodicity)
            if users.count > 0
                users.each do |one_user|
                    UserDigestMailer.with(user: one_user, message: message, mail_subject: subject).dw_digest.deliver_now
                end
            end
            message.sended = true
            message.save
        end
    end
end
