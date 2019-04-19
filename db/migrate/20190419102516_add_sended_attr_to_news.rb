class AddSendedAttrToNews < ActiveRecord::Migration[5.2]
    def change
        add_column :news, :sended, :boolean, null: false, default: false
    end
end
