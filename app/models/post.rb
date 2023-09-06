class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :photos


  validates :prompt, presence: true
end
