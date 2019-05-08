class DeleteIsAdminAttrFromUser < ActiveRecord::Migration[5.2]
    def change
        remove_column :users, :isadmin
        remove_column :news, :mail_digest
    end
end
