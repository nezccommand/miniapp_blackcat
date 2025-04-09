class AddEasyQuestionIdToChoices < ActiveRecord::Migration[8.0]
  def change
    add_column :choices, :easy_question_id, :integer
    add_foreign_key :choices, :easy_questions
  end
end
