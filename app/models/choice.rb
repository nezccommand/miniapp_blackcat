class Choice < ApplicationRecord
  belongs_to :question

  def image_path
    image.present? ? ActionController::Base.helpers.asset_path(image) : nil
  end
end
