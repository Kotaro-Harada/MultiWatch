class CreateFriendships < ActiveRecord::Migration[6.1]
  def change
    create_table :friendships do |t|
      t.integer :from_user_id, null: false
      t.integer :to_user_id, null: false

      t.timestamps
    end
    add_index :friendships, :from_user_id
    add_index :friendships, :to_user_id
    add_index :friendships, [:from_user_id, :to_user_id], unique: true
  end
end
