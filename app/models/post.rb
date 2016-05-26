class Post < ActiveRecord::Base

  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favoriting_users, through: :favorite, source: :user

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings


  validates :title, presence: true, uniqueness: true, length: { minimum: 7 }
  validates :body, presence: true
  validates :category, presence: true

  def self.search(search)
    where( "title ILIKE :term OR body ILIKE :term", term: "%#{search}%" )
  end

  def body_snippet
    body.length > 100 ? body[0...100] + "..." : body
  end

  def favorite_for(user)
    favorites.find_by_user_id user if user
  end

end
