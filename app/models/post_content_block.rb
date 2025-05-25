class PostContentBlock < ApplicationRecord
  belongs_to :post
  has_one_attached :image

  enum content_type: { paragraph: "paragraph", header: "header", image: "image" }

  validates :content_type, presence: true
end
