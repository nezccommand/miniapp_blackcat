class DifficultQuestion < ApplicationRecord
  has_many :choices, dependent: :destroy
end
