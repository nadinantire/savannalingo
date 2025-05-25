class CreatePostContentBlocks < ActiveRecord::Migration[7.2]
  def change
    create_table :post_content_blocks do |t|
      t.references :post, null: false, foreign_key: true
      t.string :content_type
      t.text :content
      t.integer :position

      t.timestamps
    end
  end
end
