class User < ActiveRecord::Base

  has_secure_password

  has_many :posts,    dependent: :nullify
  has_many :comments, dependent: :nullify

  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post


  validates :first_name, presence: true
  validates :last_name, presence: true

  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, uniqueness: true, presence: true, format: VALID_EMAIL_REGEX

  def full_name
    "#{first_name} #{last_name}"
  end

end
