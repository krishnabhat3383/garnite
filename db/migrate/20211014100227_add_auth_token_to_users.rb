# frozen_string_literal: true

class AddAuthTokenToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :authentication_token, :string
  end
end
