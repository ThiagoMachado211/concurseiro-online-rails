class Admin::PositionsController < Admin::CrudController
  private

  def model_class
    Position
  end

  def resource_params
    params.require(:position).permit(:name)
  end

  def collection_path
    admin_positions_path
  end

  def resource_label
    "Cargo"
  end
end