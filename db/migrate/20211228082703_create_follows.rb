class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows do |t|
      t.string :name, null: false
      t.string :display_name
      t.integer :user_id, null: false
      t.belongs_to :user

      t.timestamps
    end
  end
end
