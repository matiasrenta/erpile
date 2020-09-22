class AddUserIdToCashClosings < ActiveRecord::Migration
  def change
    add_column :cash_closings, :user_id, :integer
  end
end
