class Exam < ApplicationRecord
  belongs_to :exam_board
  belongs_to :institution
  belongs_to :position

  has_many :questions, dependent: :restrict_with_error

  enum :level, {
    not_informed: 0,
    elementary: 1,
    high_school: 2,
    technical: 3,
    higher_education: 4
  }

  validates :name, presence: true
  validates :year, presence: true,
                   numericality: {
                     only_integer: true,
                     greater_than: 1900
                   }
end