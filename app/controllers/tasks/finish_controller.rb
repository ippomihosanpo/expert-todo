class Tasks::FinishController < ApplicationController
  before_action :set_task, only: [:update]

  # タスクの完了
  def update
    @tasks = Task.list_by_user_id(user_id: @current_user.id)
    @task.finish(date: Time.zone.today)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end
end
