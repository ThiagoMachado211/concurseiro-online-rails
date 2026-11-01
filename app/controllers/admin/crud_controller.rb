class Admin::CrudController < Admin::BaseController
  before_action :set_resource, only: [:edit, :update, :destroy]

  def index
    @resources = model_class.order(:name)
  end

  def new
    @resource = model_class.new
  end

  def create
    @resource = model_class.new(resource_params)

    if @resource.save
      redirect_to collection_path,
                  notice: "#{resource_label} criado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @resource.update(resource_params)
      redirect_to collection_path,
                  notice: "#{resource_label} atualizado com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @resource.destroy
      redirect_to collection_path,
                  notice: "#{resource_label} excluído com sucesso."
    else
      redirect_to collection_path,
                  alert: @resource.errors.full_messages.to_sentence
    end
  end

  private

  def set_resource
    @resource = model_class.find(params[:id])
  end
end