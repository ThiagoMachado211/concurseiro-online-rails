class Attempt < ApplicationRecord
  belongs_to :user
  belongs_to :question

  validates :answer, presence: true

  scope :correct, -> { where(correct: true) }
  scope :incorrect, -> { where(correct: false) }
end