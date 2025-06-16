class Book < ApplicationRecord
  belongs_to :user
  belongs_to :category_book
  has_one_attached :pdf
  has_one_attached :image
 enum approval: { not_yet_paid: 0, paid: 1 }
  enum status:   { pending: 0, published: 1, rejected: 2 }

before_save :destroy_if_rejected

private

def destroy_if_rejected
  self.destroy if status_changed? && status == "rejected"
end
end
