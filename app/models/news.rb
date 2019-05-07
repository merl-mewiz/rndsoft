class News < ApplicationRecord
    resourcify

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

    def self.send_digest2(periodicity)
        case periodicity
        when 1
            digest = Post.where(created_at: ((Time.zone.now - 1.day).beginning_of_day)..((Time.zone.now - 1.day).end_of_day))
            subject = 'Ежедневный дайджест'
        when 2
            digest = Post.where(created_at: (Time.zone.now.beginning_of_week - 41.hour)..(Time.zone.now.end_of_week - 41.hour))
            subject = 'Еженедельный дайджест'
        end
        users = User.where(mail_digest: periodicity)

        if digest && users.count > 0
            users.each do |one_user|
                UserDigestMailer.with(user: one_user, message: digest, mail_subject: subject).dw_digest.deliver_now
            end
        end
    end
end
