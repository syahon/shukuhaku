class Room < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy
  validates :user_id, presence: true
  validates :room_name, presence: true, length: { maximum: 50 }
  validates :introduction, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :address, presence: true
end
