class CreateWhispers < ActiveRecord::Migration[6.1]
  def change
    create_table :whispers do |t|
      t.integer :send_user_id, null: false
      t.string :message, null: false
      t.string :receive_user_name, null: false
      t.string :send_user_name, null: false

      t.timestamps
    end
  end
end
