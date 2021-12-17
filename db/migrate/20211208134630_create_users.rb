class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :follow
      t.string :email
      t.string :later
      t.string :password_digest

      t.timestamps
    end
  end
end
