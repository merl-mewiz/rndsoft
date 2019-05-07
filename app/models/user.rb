class User < ApplicationRecord
    rolify

    has_many :posts
    after_create :set_default_role

    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

    validates :username, presence: true, uniqueness: { case_sensitive: false }

    private
        def set_default_role
            add_role(:author)
        end
end
