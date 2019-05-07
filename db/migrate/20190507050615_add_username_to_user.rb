class AddUsernameToUser < ActiveRecord::Migration[5.2]
    def self.up
        change_table :users do |t|
            t.string :username, null: false, default: ""
        end

        add_index :users, :username, unique: true
    end

    def self.down
        raise ActiveRecord::IrreversibleMigration
    end
end
