class Post < ApplicationRecord
  belongs_to :user

  has_many_attached :images  # for multiple image uploads
  has_many :post_content_blocks, -> { order(:position) }, dependent: :destroy
  accepts_nested_attributes_for :post_content_blocks, allow_destroy: true
  has_rich_text :body



  validates :title, :body, :status, presence: true
  before_save :generate_slug

def generate_slug
  self.slug = title.parameterize if slug.blank?
end
end
