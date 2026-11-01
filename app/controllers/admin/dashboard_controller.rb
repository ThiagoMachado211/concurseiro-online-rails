class Admin::DashboardController < Admin::BaseController
  def index
    @users_count = User.count
    @questions_count = Question.count
    @published_questions_count = Question.published.count
    @exams_count = Exam.count
    @subjects_count = Subject.count
    @topics_count = Topic.count
    @attempts_count = Attempt.count
  end
end