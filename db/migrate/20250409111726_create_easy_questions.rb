class CreateEasyQuestions < ActiveRecord::Migration[8.0]
  def change
    create_table :easy_questions do |t|
      t.string :content
      t.text :explanation
      t.string :correct_image
      t.timestamps
    end
  end
end
