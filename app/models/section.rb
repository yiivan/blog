class Section < ActiveRecord::Base
  belongs_to :post

  validates :image, presence: true
  validates :description, presence: true

  mount_uploader :image, ImageUploader
end
