class Section < ActiveRecord::Base
  belongs_to :post

  validates :name, presence: true
  validates :description, presence: true

  mount_uploader :image, ImageUploader
end
