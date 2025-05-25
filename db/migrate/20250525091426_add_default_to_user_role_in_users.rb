class AddDefaultToUserRoleInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :user_role, 'visitor'
  end
end
