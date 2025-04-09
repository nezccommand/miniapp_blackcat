class Choice < ApplicationRecord
  belongs_to :question, dependent: :destroy, optional: true
  belongs_to :difficult_question, dependent: :destroy, optional: true
  belongs_to :easy_question, dependent: :destroy, optional: true

  def image_path
    image.present? ? ActionController::Base.helpers.asset_path(image) : nil
  end

  validate :must_belong_to_only_one_question_type

  private

  def must_belong_to_only_one_question_type
    attached_ids = [question_id, difficult_question_id, easy_question_id].compact

    if attached_ids.empty?
      errors.add(:base, "question_id、difficult_question_id、easy_question_id のいずれか1つが必要です")
    elsif attached_ids.size > 1
      errors.add(:base, "question_id、difficult_question_id、easy_question_id のうち1つだけにしてください")
    end
  end
end