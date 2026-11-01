class HistoryController < ApplicationController
  before_action :authenticate_user!

  def index
    @attempts = current_user.attempts
                            .includes(question: :subject)
                            .order(created_at: :desc)

    @total_attempts = @attempts.count
    @unique_questions = @attempts.select(:question_id).distinct.count
    @correct_attempts = @attempts.where(correct: true).count
    @incorrect_attempts = @attempts.where(correct: false).count

    @accuracy =
      if @total_attempts.positive?
        (@correct_attempts.to_f / @total_attempts * 100).round(1)
      else
        0
      end

    @performance_by_subject =
      current_user.attempts
                  .joins(question: :subject)
                  .group("subjects.id", "subjects.name")
                  .order("subjects.name")
                  .pluck(
                    "subjects.name",
                    Arel.sql("COUNT(attempts.id)"),
                    Arel.sql("SUM(CASE WHEN attempts.correct = TRUE THEN 1 ELSE 0 END)")
                  )
  end
end