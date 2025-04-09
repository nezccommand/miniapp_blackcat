class BlackcatQuizzesController < ApplicationController
  before_action :set_questions, only: [ :show ]

  def top
    session[:question_index] = 0
    session[:answers] = []
    session[:dif_question_index] = 0
    session[:dif_answers] = []
  end

  def show
    @question = @questions[session[:question_index]]
  end

  def answer
    @questions = Question.all
    @question = @questions.find(params[:id])

    choice = Choice.find(params[:choice_id])

    add_or_update_answer(@question.id, choice.id, choice.correct)
    next_question_index = @questions.index(@question) + 1

    if next_question_index >= @questions.count
      redirect_to result_blackcat_quiz_path
    else
      session[:question_index] = next_question_index
      redirect_to blackcat_quiz_path(session[:question_index])
    end
  end

  def result
    @answers = session[:answers]
  end

  private

  def set_questions
    @questions = Question.includes(:choices).order(:id)
  end

  def add_or_update_answer(question_id, choice_id, correct)
    updated = false
    session[:answers] = session[:answers].map do |answer|
      if answer["question_id"] == question_id
        updated = true
        { question_id: question_id, choice_id: choice_id, correct: correct }
      else
        answer
      end
    end

    unless updated
      session[:answers] << { "question_id" => question_id, "choice_id" => choice_id, "correct" => correct }
    end
  end
end
# 並び替えゲームを作る
