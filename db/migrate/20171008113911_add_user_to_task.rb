class AddUserToTask < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :user_id, :integer
    add_column :users, :twitter_handle, :string
  end
end
