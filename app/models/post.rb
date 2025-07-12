class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many_attached :images
  has_rich_text :body
   enum status: { draft: 0, published: 1, archived: 2 }
  validates :title, :status, presence: true
  scope :published, -> { where(status: 'published') }
  scope :recent, -> { order(published_at: :desc) }
  before_save :generate_slug

def generate_slug
  self.slug = title.parameterize if slug.blank?
end
end
