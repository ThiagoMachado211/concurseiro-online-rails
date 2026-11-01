class Admin::QuestionsController < Admin::BaseController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :load_form_options, only: [:new, :create, :edit, :update]

  def index
    @questions = Question
                   .includes(:subject, exam: [:exam_board, :institution])
                   .order(created_at: :desc)
  end

  def show
  end

  def new
    @question = Question.new(
      modality: :multiple_choice,
      difficulty: :not_defined,
      status: :draft,
      annulled: false,
      outdated: false
    )

    build_missing_alternatives
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to admin_question_path(@question),
                  notice: "Questão criada com sucesso."
    else
      build_missing_alternatives
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    build_missing_alternatives
  end

  def update
    if @question.update(question_params)
      redirect_to admin_question_path(@question),
                  notice: "Questão atualizada com sucesso."
    else
      build_missing_alternatives
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @question.attempts.exists?
      redirect_to admin_questions_path,
                  alert: "Esta questão já possui respostas e não pode ser excluída."
      return
    end

    @question.destroy!

    redirect_to admin_questions_path,
                notice: "Questão excluída com sucesso."
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def load_form_options
    @exams = Exam
               .includes(:exam_board, :institution, :position)
               .order(year: :desc, name: :asc)

    @subjects = Subject.order(:name)
    @topics = Topic.includes(:subject).order(:name)
  end

  def question_params
    params.require(:question).permit(
      :exam_id,
      :subject_id,
      :number,
      :statement,
      :modality,
      :difficulty,
      :correct_answer,
      :status,
      :annulled,
      :outdated,
      topic_ids: [],
      question_alternatives_attributes: [
        :id,
        :letter,
        :text,
        :_destroy
      ]
    )
  end

  def build_missing_alternatives
    existing_letters = @question.question_alternatives.map(&:letter)

    %w[A B C D E].each do |letter|
      next if existing_letters.include?(letter)

      @question.question_alternatives.build(letter: letter)
    end
  end
end