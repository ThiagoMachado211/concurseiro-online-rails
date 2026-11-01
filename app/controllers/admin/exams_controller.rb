class Admin::ExamsController < Admin::BaseController
  before_action :set_exam, only: [:edit, :update, :destroy]
  before_action :load_options, only: [:new, :create, :edit, :update]

  def index
    @exams = Exam
               .includes(:exam_board, :institution, :position)
               .order(year: :desc, name: :asc)
  end

  def new
    @exam = Exam.new
  end

  def create
    @exam = Exam.new(exam_params)

    if @exam.save
      redirect_to admin_exams_path,
                  notice: "Prova criada com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @exam.update(exam_params)
      redirect_to admin_exams_path,
                  notice: "Prova atualizada com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @exam.questions.exists?
      redirect_to admin_exams_path,
                  alert: "Esta prova possui questões e não pode ser excluída."
      return
    end

    @exam.destroy!

    redirect_to admin_exams_path,
                notice: "Prova excluída com sucesso."
  end

  private

  def set_exam
    @exam = Exam.find(params[:id])
  end

  def load_options
    @exam_boards = ExamBoard.order(:name)
    @institutions = Institution.order(:name)
    @positions = Position.order(:name)
  end

  def exam_params
    params.require(:exam).permit(
      :name,
      :year,
      :exam_board_id,
      :institution_id,
      :position_id,
      :education_level
    )
  end
end