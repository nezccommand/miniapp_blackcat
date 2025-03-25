class Choice < ApplicationRecord
  belongs_to :question
  has_one_attached :image
end
