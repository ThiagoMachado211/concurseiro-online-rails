class QuestionAlternative < ApplicationRecord
  belongs_to :question

  validates :letter, presence: true,
                     uniqueness: { scope: :question_id }

  validates :text, presence: true
end