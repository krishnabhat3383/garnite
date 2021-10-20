# frozen_string_literal: true

require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  def setup
    @creator = create(:user)
    @assignee = create(:user)
    @task = create(:task, assigned_user: @assignee, task_owner: @creator)
    @creator_headers = headers(@creator)
    @assignee_headers = headers(@assignee)
  end

  def headers(user, options = {})
    {
      "X-Auth-Token" => user.authentication_token,
      "X-Auth-Email" => user.email
    }.merge(options)
  end

  def test_should_list_all_tasks_for_valid_user
    get tasks_path, headers: @creator_headers
    assert_response :success
    response_body = response.parsed_body
    all_tasks = response_body["tasks"]

    pending_tasks_count = Task.where(progress: "pending").count
    completed_tasks_count = Task.where(progress: "completed").count

    assert_equal all_tasks["pending"].length, pending_tasks_count
    assert_equal all_tasks["completed"].length, completed_tasks_count
  end

  def test_should_create_valid_task
    post tasks_path,
      params: { task: { title: "Learn Ruby", task_owner_id: @creator.id, assigned_user_id: @assignee.id } },
      headers: @creator_headers
    assert_response :success
    response_json = response.parsed_body
    assert_equal response_json["notice"], t("successfully_created", entity: "Task")
  end

  def test_shouldnt_create_task_without_title
    post tasks_path, params: { task: { title: "", task_owner_id: @creator.id, assigned_user_id: @assignee.id } },
    headers: @creator_headers

    assert_response :unprocessable_entity
    response_json = response.parsed_body
    assert_equal response_json["error"], "Title can't be blank"
  end

  def test_creator_can_update_any_task_fields
    new_title = "#{@task.title}-(updated)"
    task_params = { task: { title: new_title, assigned_user_id: 1 } }

    put tasks_path(@task.slug), params: task_params, headers: @creator_headers
    assert_response :success
    @task.reload
    assert_equal @task.title, new_title
    assert_equal @task.assigned_user_id, 1
  end

  def test_should_destroy_task
    assert_difference "Task.count", -1 do
      delete task_path(@task.slug)
    end
    assert_response :ok
  end
end
