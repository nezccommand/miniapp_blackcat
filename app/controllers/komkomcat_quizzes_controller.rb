class KomkomcatQuizzesController < ApplicationController
  before_action :set_questions, only: [ :show ]

  def show
    @difficult_question = @difficult_questions[session[:dif_question_index]]
  end

  def answer
    @difficult_questions = DifficultQuestion.all
    @difficult_question = @difficult_questions.find(params[:id])

    choice = @difficult_question.choices.find(params[:choice_id])

    add_or_update_answer(@difficult_question.id, choice.id, choice.correct)
    next_question_index = @difficult_questions.index(@difficult_question) + 1

    if next_question_index >= @difficult_questions.count
      redirect_to result_komkomcat_quiz_path
    else
      session[:dif_question_index] = next_question_index
      redirect_to komkomcat_quiz_path(session[:dif_question_index])
    end
  end

  def result
    @answers = session[:dif_answers]
  end

  private

  def set_questions
    @difficult_questions = DifficultQuestion.includes(:choices).order(:id)
  end

  def add_or_update_answer(difficult_question_id, choice_id, correct)
    updated = false
    session[:dif_answers] = session[:dif_answers].map do |answer|
      if answer["question_id"] == difficult_question_id
        updated = true
        { question_id: difficult_question_id, choice_id: choice_id, correct: correct }
      else
        answer
      end
    end

    unless updated
      session[:dif_answers] << { "question_id" => difficult_question_id, "choice_id" => choice_id, "correct" => correct }
    end
  end
end
