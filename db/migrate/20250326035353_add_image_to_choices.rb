class AddImageToChoices < ActiveRecord::Migration[7.2]
  def change
    add_column :choices, :image, :string
  end
end
