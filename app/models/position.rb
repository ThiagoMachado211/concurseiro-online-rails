class Position < ApplicationRecord
  has_many :exams, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true
end