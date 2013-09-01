class Api::TasksController < Api::BaseController
  before_filter :require_authentication

  def create
    render json: current_user.tasks.create(task_params_without_id).to_json
  end

  def update
    task = task_from_params
    if task && task.update_attributes!(task_params_without_id)
      render json: task.to_json
    else
      head status: :unprocessable
    end
  end

  def index
    render json: current_user.tasks.to_json
  end

  def show
    task = task_from_params
    if task
      render json: task.to_json
    else
      head status: :not_found
    end
  end

  def destroy
    task = task_from_params
    if task
      task.destroy
      head status: :ok
    else
      head status: :not_found
    end
  end

  private
  def task_from_params
    current_user.tasks.where(id: params_id).first
  end

  def task_params_without_id
    params.permit(:description, :completed, :due_date, :priority)
  end

  def params_id
    params.permit(:id)[:id]
  end
end
