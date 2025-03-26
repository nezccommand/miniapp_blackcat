class CreateUserAnswerMap < ActiveRecord::Migration[7.2]
  def change
    create_table :user_answer_maps do |t|
      t.references :question, null: false, foreign_key: true
      t.references :choice, null: false, foreign_key: true
      t.boolean :correct, default: false
      t.string :session_id
      t.timestamps
    end
  end
end
