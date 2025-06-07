class Book < ApplicationRecord
  belongs_to :user
  has_one_attached :pdf
  has_one_attached :image
  enum :approval, [:not_yet_paid, :paid]
  enum :status, [:pending, :published, :rejected]

before_save :destroy_if_rejected

private

def destroy_if_rejected
  self.destroy if status_changed? && status == "rejected"
end
end
