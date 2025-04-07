class DifficultQuestion < ApplicationRecord
  has_many :choices, dependent: :destroy

  def correct_image_path
    correct_image.present? ? ActionController::Base.helpers.asset_path(correct_image) : nil
  end
end
