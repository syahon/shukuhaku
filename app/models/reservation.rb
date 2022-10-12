class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room
  scope :recent, -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :room_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :sum_people, presence: true, numericality: { greater_than: 0 }
  validates :total_price, presence: true, numericality: { greater_than: 0 }
  validate :start_date_check, :end_date_check, :start_end_check

  def start_date_check
    return if start_date.nil? || end_date.nil?
    errors.add(:start_date, "は明日以降の日付を選択してください") if
    self.start_date <= Date.today
  end

  def end_date_check
    return if start_date.nil? || end_date.nil?
    errors.add(:end_date, "は開始日より後の日付にしてください") if
    self.start_date > self.end_date
  end

  def start_end_check
    return if start_date.nil? || end_date.nil?
    errors.add :base, "日帰りでの予約はできません" if
    self.start_date == self.end_date
  end
end
