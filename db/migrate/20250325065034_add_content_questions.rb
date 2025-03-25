class AddContentQuestions < ActiveRecord::Migration[7.2]
  def change
    add_column :questions, :content, :string
    add_column :questions, :explanation, :text
  end
end
