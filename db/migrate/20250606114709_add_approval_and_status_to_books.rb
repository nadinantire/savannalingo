class AddApprovalAndStatusToBooks < ActiveRecord::Migration[7.2]
  def change
    add_column :books, :approval, :integer, default: 0
    add_column :books, :status, :integer, default: 0
  end
end
