class AddCategoryBookToBooks < ActiveRecord::Migration[7.2]
  def change
    add_reference :books, :category_book, null: false, foreign_key: true
  end
end
