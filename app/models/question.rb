class Question < ApplicationRecord
  belongs_to :exam
  belongs_to :subject

  has_many :question_alternatives,
           dependent: :destroy

  has_many :question_topics,
           dependent: :destroy

  has_many :topics,
           through: :question_topics

  has_many :attempts,
           dependent: :restrict_with_error

  accepts_nested_attributes_for :question_alternatives,
                              allow_destroy: true,
                              reject_if: proc { |attributes|
                                attributes["text"].blank?
                              }

  enum :modality, {
    multiple_choice: 0,
    true_false: 1
  }

  enum :difficulty, {
    not_defined: 0,
    easy: 1,
    medium: 2,
    hard: 3
  }

  enum :status, {
    draft: 0,
    pending_review: 1,
    published: 2,
    archived: 3
  }

  validates :statement, presence: true

  validates :number,
            uniqueness: { scope: :exam_id },
            allow_nil: true

  def public_id
    format("Q%06d", id)
  end
end