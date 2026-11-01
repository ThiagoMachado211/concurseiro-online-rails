class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { student: 0, admin: 1 }

  has_many :attempts, dependent: :destroy
  has_many :answered_questions, through: :attempts, source: :question

  validates :name, presence: true, length: { minimum: 2, maximum: 100 }

  scope :active, -> { where(active: true) }
end