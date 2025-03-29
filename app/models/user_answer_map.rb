class UserAnswerMap < ApplicationRecord
  belongs_to :question
  belongs_to :choice
end
# このモデルは使いません