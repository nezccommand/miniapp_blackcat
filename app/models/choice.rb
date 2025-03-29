class Choice < ApplicationRecord
  belongs_to :question, dependent: :destroy

  def image_path
    image.present? ? ActionController::Base.helpers.asset_path(image) : nil
  end
end
