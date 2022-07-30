class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }

  mount_uploader :image, ImageUploader
end
