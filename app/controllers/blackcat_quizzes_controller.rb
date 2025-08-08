class BlackcatQuizzesController < ApplicationController
  before_action :set_questions, only: [ :show, :answer ]

  def top
    session[:question_index] = 0
    session[:answers] = []
    session[:dif_question_index] = 0
    session[:dif_answers] = []
    session[:easy_question_index] = 0
    session[:easy_answers] = []
  end

  def show
    @question = @questions[session[:question_index]]
  end

  def answer
    @question = @questions.find(params[:id])
    choice = Choice.find(params[:choice_id])

    question_index = @questions.index(@question)
    add_or_update_answer(question_index, @question.id, choice.id, choice.correct)

    next_question_index = question_index + 1
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

  def add_or_update_answer(index, question_id, choice_id, correct)
    session[:answers] ||= []
    session[:answers][index] = {
      "question_id" => question_id,
      "choice_id" => choice_id,
      "correct" => correct
    }
  end
end
# 並び替えゲームを作る
