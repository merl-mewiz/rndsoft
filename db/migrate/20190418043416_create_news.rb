class CreateNews < ActiveRecord::Migration[5.2]
  def change
    create_table :news do |t|
        t.string :title, null: false, default: ""
        t.integer :mail_digest, null: false, default: 2
        t.text :body

        t.timestamps
    end
  end
end
