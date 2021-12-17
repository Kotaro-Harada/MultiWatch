class CreateApis < ActiveRecord::Migration[6.1]
  def change
    create_table :apis do |t|

      t.timestamps
    end
  end
end
