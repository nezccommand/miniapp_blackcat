class AddQuestionIdToChoices < ActiveRecord::Migration[7.2]
  def change
    add_column :choices, :question_id, :integer, null: false
    add_foreign_key :choices, :questions
  end
end
