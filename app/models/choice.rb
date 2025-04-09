class Choice < ApplicationRecord
  belongs_to :question, dependent: :destroy, optional: true
  belongs_to :difficult_question, dependent: :destroy, optional: true

  def image_path
    image.present? ? ActionController::Base.helpers.asset_path(image) : nil
  end

  validate :must_belong_to_one_question_type

  private

  def must_belong_to_one_question_type
    if question_id.blank? && difficult_question_id.blank?
      errors.add(:base, "question_id か difficult_question_id のどちらかが必要")
    elsif question_id.present? && difficult_question_id.present?
      errors.add(:base, "question_id と difficult_question_id の両方は不可能")
    end
  end
end
