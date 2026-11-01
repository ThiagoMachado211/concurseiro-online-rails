class QuestionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @questions = Question
                   .published
                   .includes(:subject, :topics, :question_alternatives, :attempts, exam: [:exam_board, :institution, :position])

    # Palavra-chave
    if params[:keyword].present?
      term = "%#{ActiveRecord::Base.sanitize_sql_like(params[:keyword])}%"
      @questions = @questions.where("questions.statement ILIKE ?", term)
    end

    # Disciplina
    if params[:subject_id].present?
      @questions = @questions.where(subject_id: params[:subject_id])
    end

    # Assunto
    if params[:topic_id].present?
      @questions = @questions
                     .joins(:question_topics)
                     .where(question_topics: { topic_id: params[:topic_id] })
    end

    # Banca
    if params[:exam_board_id].present?
      @questions = @questions
                     .joins(:exam)
                     .where(exams: { exam_board_id: params[:exam_board_id] })
    end

    # Instituição
    if params[:institution_id].present?
      @questions = @questions
                     .joins(:exam)
                     .where(exams: { institution_id: params[:institution_id] })
    end

    # Ano
    if params[:year].present?
      @questions = @questions
                     .joins(:exam)
                     .where(exams: { year: params[:year] })
    end

    # Cargo
    if params[:position_id].present?
      @questions = @questions
                     .joins(:exam)
                     .where(exams: { position_id: params[:position_id] })
    end

    # Nível
    if params[:level].present?
      @questions = @questions
                     .joins(:exam)
                     .where(exams: { level: params[:level] })
    end

    # Modalidade
    if params[:modality].present?
      @questions = @questions.where(modality: params[:modality])
    end

    # Dificuldade
    if params[:difficulty].present?
      @questions = @questions.where(difficulty: params[:difficulty])
    end

    # Excluir anuladas/desatualizadas
    @questions = @questions.where(annulled: false) if params[:exclude_annulled] == "1"
    @questions = @questions.where(outdated: false) if params[:exclude_outdated] == "1"

    @questions = @questions.distinct.order(created_at: :desc)

    # Opções dos filtros
    @subjects = Subject.order(:name)
    @topics = Topic.order(:name)
    @exam_boards = ExamBoard.order(:name)
    @institutions = Institution.order(:name)
    @positions = Position.order(:name)
    @years = Exam.distinct.order(year: :desc).pluck(:year)
  end

  def answer
    @question = Question.published.find(params[:id])

    answer = params[:answer].to_s.upcase.strip

    unless valid_answer?(@question, answer)
      redirect_back(
        fallback_location: questions_path,
        alert: "Selecione uma resposta válida."
      )
      return
    end

    correct =
      !@question.annulled? &&
      answer == @question.correct_answer.to_s.upcase.strip

    Attempt.create!(
      user: current_user,
      question: @question,
      answer: answer,
      correct: correct
    )

    redirect_to questions_path(
      request.query_parameters.merge(
        answered: @question.id
      )
    )
  end

  private

  def valid_answer?(question, answer)
    if question.true_false?
      %w[C E].include?(answer)
    else
      question.question_alternatives.exists?(letter: answer)
    end
  end


end