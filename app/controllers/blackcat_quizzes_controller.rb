class BlackcatQuizzesController < ApplicationController
  before_action :set_questions, only: [ :top, :show ]

  def top
    session[:question_index] = 0
    session[:correct_answer_count] = 0
    session[:answers] = []
  end

  def show
    @question = @questions[session[:question_index]]
  end

  def answer
    @questions = Question.all
    @question = @questions.find(params[:id])
    Rails.logger.debug "session[:answers]: #{session[:answers]}"

    choice = Choice.find(params[:choice_id])

    session[:answers] << { question_id: @question.id, choice_id: choice.id, correct: choice.correct }
    session[:correct_answer_count] += 1 if choice.correct?
    session[:question_index] += 1
    if session[:question_index] < 1
      redirect_to blackcat_quiz_path(session[:question_index])
    else
      redirect_to result_blackcat_quiz_path
    end
  end

  def result
    @answers = session[:answers]
    @score = session[:correct_answer_count]
    logger.debug "Session Answers: #{@answers.inspect}"
  end

  private

  def set_questions
    @questions = Question.includes(:choices).limit(1)
  end
end
