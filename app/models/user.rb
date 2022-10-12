class User < ApplicationRecord
  has_many :rooms, dependent: :destroy
  has_many :reservations
  has_one_attached :image
  attr_accessor :remember_token
  before_save { mail.downcase! }
  validates :user_name, presence: true
  MAIL_REGEX = /\A[\w+-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :mail, presence: true,
                   uniqueness: { case_sensitive: false },
                   format: { with: MAIL_REGEX }
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }, allow_nil: true
  validates :image, content_type: { in: ['image/jpeg', 'image/jpg', 'image/png'],
                                                         message: "は以下のファイル形式で入力してください  .jpeg .jpg .png" },
                     size:        { less_than: 5.megabytes, message: "の容量が5MBを超えています" }

  class << self
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

end
