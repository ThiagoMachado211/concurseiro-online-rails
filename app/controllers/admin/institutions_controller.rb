class Admin::InstitutionsController < Admin::CrudController
  private

  def model_class
    Institution
  end

  def resource_params
    params.require(:institution).permit(:name, :acronym)
  end

  def collection_path
    admin_institutions_path
  end

  def resource_label
    "Instituição"
  end
end