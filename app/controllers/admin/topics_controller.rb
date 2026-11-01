class Admin::TopicsController < Admin::BaseController
  before_action :set_topic, only: [:edit, :update, :destroy]
  before_action :load_options, only: [:new, :create, :edit, :update]

  def index
    @topics = Topic
                .includes(:subject, :parent)
                .order("subjects.name", :name)
                .references(:subject)
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      redirect_to admin_topics_path,
                  notice: "Assunto criado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @topic.update(topic_params)
      redirect_to admin_topics_path,
                  notice: "Assunto atualizado com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @topic.children.exists?
      redirect_to admin_topics_path,
                  alert: "Este assunto possui subassuntos e não pode ser excluído."
      return
    end

    if @topic.questions.exists?
      redirect_to admin_topics_path,
                  alert: "Este assunto está associado a questões e não pode ser excluído."
      return
    end

    @topic.destroy!

    redirect_to admin_topics_path,
                notice: "Assunto excluído com sucesso."
  end

  private

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def load_options
    @subjects = Subject.order(:name)

    @possible_parents =
      Topic
        .includes(:subject)
        .order("subjects.name", :name)
        .references(:subject)

    if @topic&.persisted?
      @possible_parents = @possible_parents.where.not(id: @topic.id)
    end
  end

  def topic_params
    params.require(:topic).permit(
      :name,
      :subject_id,
      :parent_id
    )
  end
end