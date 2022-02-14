class AddReceiveUserIdToWhispers < ActiveRecord::Migration[6.1]
  def change
    add_column :whispers, :receive_user_id, :integer, null: false
    add_column :whispers, :message_type, :integer
  end
end
