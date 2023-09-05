class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :photos
  has_one :programmation

  validates :prompt, presence: true
  validates :many_imgs, presence: true
end
