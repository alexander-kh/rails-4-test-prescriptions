class AddPublicFields < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :public, :boolean, default: false
    add_column :users, :admin, :boolean, default: false
  end
end
