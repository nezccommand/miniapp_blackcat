class AddCorrectImageToQuestions < ActiveRecord::Migration[8.0]
  def change
    add_column :questions, :correct_image, :string
  end
end
