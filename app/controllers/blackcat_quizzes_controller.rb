class BlackcatQuizzesController < ApplicationController
  before_action :set_questions, only: [ :show ]

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

    choice = Choice.find(params[:choice_id])

    add_or_update_answer(@question.id, choice.id, choice.correct)

    session[:correct_answer_count] += 1 if choice.correct?
    if session[:question_index] + 1 >= @questions.count
      redirect_to result_blackcat_quiz_path
    else
      session[:question_index] += 1
      redirect_to blackcat_quiz_path(session[:question_index])
    end
  end

  def result
    @answers = session[:answers]
    @score = session[:correct_answer_count]
    Rails.logger.debug "Answers: #{@answers}"
  end

  private

  def set_questions
    @questions = Question.includes(:choices).limit(1)
  end

  def add_or_update_answer(question_id, choice_id, correct)
    existing_answer = session[:answers].find { |answer| answer["question_id"] == question_id }

    if existing_answer
      existing_answer[:choice_id] = choice_id
      existing_answer[:correct] = correct
    else
      session[:answers] << { question_id: question_id, choice_id: choice_id, correct: correct }
    end
  end
end
