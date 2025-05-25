class CreateBooks < ActiveRecord::Migration[7.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :writer
      t.string :description
      t.string :price
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
