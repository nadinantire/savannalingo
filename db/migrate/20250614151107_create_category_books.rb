class CreateCategoryBooks < ActiveRecord::Migration[7.2]
  def change
    create_table :category_books do |t|
      t.string :name

      t.timestamps
    end
  end
end
