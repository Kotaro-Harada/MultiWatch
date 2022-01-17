class ChangeDatatypeCreatedAtOfWhispers < ActiveRecord::Migration[6.1]
  def up
    change_column :whispers, :created_at, :date
    change_column :whispers, :updated_at, :date
  end
end
