class Picture < ApplicationRecord
  attr_accessor :remote_photo_url
  
  belongs_to :post
  mount_uploader :photo, PhotoUploader
end
