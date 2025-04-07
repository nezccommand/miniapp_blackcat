class AddCorrectImageToDifficultQuestions < ActiveRecord::Migration[8.0]
  def change
    add_column :difficult_questions, :correct_image, :string
  end
end
