class Question < ApplicationRecord
  has_many :choices, dependent: :destroy

  def correct_image_path
    "/assets/#{correct_image}" if correct_image.present?
  end
end
