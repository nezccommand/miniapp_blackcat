class CatQuizzesController < ApplicationController
  before_action :set_questions, only: [ :show ]

  def show
    @easy_question = @easy_questions[session[:easy_question_index]]
  end

  def answer
    @easy_questions = EasyQuestion.all
    @easy_question = @easy_questions.find(params[:id])

    choice = @easy_question.choices.find(params[:choice_id])

    add_or_update_answer(@easy_question.id, choice.id, choice.correct)
    next_question_index = @easy_questions.index(@easy_question) + 1

    if next_question_index >= @easy_questions.count
      redirect_to result_cat_quiz_path
    else
      session[:easy_question_index] = next_question_index
      redirect_to cat_quiz_path(session[:easy_question_index])
    end
  end

  def result
    @answers = session[:easy_answers]
  end

  private

  def set_questions
    @easy_questions = EasyQuestion.includes(:choices).order(:id)
  end

  def add_or_update_answer(easy_question_id, choice_id, correct)
    updated = false
    session[:easy_answers] = session[:easy_answers].map do |answer|
      if answer["question_id"] == easy_question_id
        updated = true
        { question_id: easy_question_id, choice_id: choice_id, correct: correct }
      else
        answer
      end
    end

    unless updated
      session[:easy_answers] << { "question_id" => easy_question_id, "choice_id" => choice_id, "correct" => correct }
    end
  end
end
