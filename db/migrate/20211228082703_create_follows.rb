class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows do |t|
      t.string :name, null: false
      t.string :display_name
      t.integer :user_id, null: false
      t.boolean :platform, null: false
      t.string :channel_id, null: false

      t.timestamps
    end
  end
end
