class Post < ApplicationRecord
    validates :title, :presence => {:message => 'не может быть пустым'}
end
