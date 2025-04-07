class CreateDifficultQuestions < ActiveRecord::Migration[8.0]
  def change
    create_table :difficult_questions do |t|
      t.string :content
      t.text :explanation
      t.timestamps
    end
  end
end
