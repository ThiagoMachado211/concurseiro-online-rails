class Admin::ExamBoardsController < Admin::CrudController
  private

  def model_class
    ExamBoard
  end

  def resource_params
    params.require(:exam_board).permit(:name, :acronym)
  end

  def collection_path
    admin_exam_boards_path
  end

  def resource_label
    "Banca"
  end
end