# frozen_string_literal: true

class AddAssignedUserToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :assigned_user_id, :integer
  end
end
