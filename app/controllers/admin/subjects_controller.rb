class Admin::SubjectsController < Admin::CrudController
  private

  def model_class
    Subject
  end

  def resource_params
    params.require(:subject).permit(:name)
  end

  def collection_path
    admin_subjects_path
  end

  def resource_label
    "Disciplina"
  end
end