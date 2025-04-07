class ChangeQuestionIdToNullableInChoices < ActiveRecord::Migration[8.0]
  def change
    change_column_null :choices, :question_id, true
  end
end
