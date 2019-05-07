class Post < ApplicationRecord
    resourcify

    belongs_to :user

    validates :title, :presence => {:message => 'не может быть пустым'}
end
