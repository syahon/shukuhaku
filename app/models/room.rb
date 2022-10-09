class Room < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy
  has_one_attached :image
  validates :user_id, presence: true
  validates :room_name, presence: true, length: { maximum: 50 }
  validates :introduction, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :address, presence: true
  validates :image, attached: true, content_type: { in: ['image/jpeg', 'image/jpg', 'image/png'],
                                                         message: "は以下のファイル形式で入力してください  .jpeg .jpg .png" },
                                         size:        { less_than: 5.megabytes,
                                                         message: "の容量が5MBを超えています" }
end
