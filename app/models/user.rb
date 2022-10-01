class User < ApplicationRecord
  has_many :rooms, dependent: :destroy
  has_many :reservations
  before_save { mail.downcase! }
  validates :user_name, presence: true
  MAIL_REGEX = /\A[\w+-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :mail, presence: true,
                   uniqueness: { case_sensitive: false },
                   format: { with: MAIL_REGEX }
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }
end
