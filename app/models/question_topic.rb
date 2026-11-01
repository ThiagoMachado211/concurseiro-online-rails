class QuestionTopic < ApplicationRecord
  belongs_to :question
  belongs_to :topic

  validates :topic_id,
            uniqueness: { scope: :question_id }
end