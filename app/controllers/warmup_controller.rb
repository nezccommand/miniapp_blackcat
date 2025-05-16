class WarmupController < ApplicationController
  def index
    Question.limit(1).pluck(:id)
    head :ok
  end
end
