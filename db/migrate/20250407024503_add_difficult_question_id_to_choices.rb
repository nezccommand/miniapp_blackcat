class AddDifficultQuestionIdToChoices < ActiveRecord::Migration[8.0]
  def change
    add_column :choices, :difficult_question_id, :integer
    add_foreign_key :choices, :difficult_questions
  end
end
