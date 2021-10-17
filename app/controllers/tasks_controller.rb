# frozen_string_literal: true

class TasksController < ApplicationController
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index
  before_action :authenticate_user_using_x_auth_token
  before_action :load_task, only: %i[show update destroy]

  def index
    tasks = policy_scope(Task)
    render status: :ok, json: { tasks: tasks }
  end

  def create
    task = Task.new(task_params.merge(task_owner_id: @current_user.id))
    if task.save
      render status: :ok, json: { notice: t("successfully_created", entity: "Task") }
    else
      errors = task.errors.full_message.to_sentence
      render status: :unprocessable_entity, json: { errors: errors }
    end
  end

  def show
    authorize @task
  end

  def update
    authorize @task
    if @task.update(task_params)
      render status: :ok, json: { notice: t("successfully_updated", entity: "task") }
    else
      render status: :unprocessable_entity,
        json: { error: @task.errors.full_messages.to_sentence }
    end
  end

  def destroy
    authorize @task
    if @task.destroy
      render status: :ok, json: { notice: t("successfully_deleted", entity: "task") }
    else
      render status: :unprocessable_entity,
        json: { error: @task.errors.full_message.to_sentence }
    end
  end

  private

    def task_params
      params.require(:task).permit(:title, :assigned_user_id)
    end

    def load_task
      @task = Task.find_by(slug: params[:slug])
      unless @task
        render status: :not_found, json: { error: t("task.not_found") }
      end
    end
end
