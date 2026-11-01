class Topic < ApplicationRecord
  belongs_to :subject

  belongs_to :parent,
             class_name: "Topic",
             optional: true

  has_many :children,
           class_name: "Topic",
           foreign_key: :parent_id,
           dependent: :restrict_with_error

  has_many :question_topics,
           dependent: :restrict_with_error

  has_many :questions,
           through: :question_topics

  validates :name, presence: true

  validate :parent_must_belong_to_same_subject

  private

  def parent_must_belong_to_same_subject
    return if parent.blank? || subject.blank?
    return if parent.subject_id == subject_id

    errors.add(
      :parent,
      "deve pertencer à mesma disciplina do assunto"
    )
  end

end