class CreateChoice < ActiveRecord::Migration[7.2]
  def change
    create_table :choices do |t|
      t.boolean :correct, default: false
      t.timestamps
    end
  end
end
