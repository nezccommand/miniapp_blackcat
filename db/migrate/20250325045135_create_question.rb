class CreateQuestion < ActiveRecord::Migration[7.2]
  def change
    create_table :questions do |t|
      t.timestamps
    end
  end
end
