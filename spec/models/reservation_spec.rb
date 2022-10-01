require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe "valid" do
    let!(:reservation) { build(:reservation) }
    let!(:today) { Date.today }

    context "全ての値が正常な場合" do
      it "データが有効であること" do
        expect(reservation).to be_valid
      end
    end

    context "start_dateが空の場合" do
      it "start_dateが無効であること" do
        reservation.start_date = nil
        expect(reservation).to_not be_valid
      end
    end

    context "start_dateの日付が過去の場合" do
      it "start_dateが無効であること" do
        reservation.start_date = today.prev_day(1)
        reservation.end_date = today.next_day(1)
        expect(reservation).to_not be_valid
      end
    end

    context "start_dateの日付が今日の場合" do
      it "start_dateが無効であること" do
        reservation.start_date = today
        reservation.end_date = today.next_day(1)
        expect(reservation).to_not be_valid
      end
    end

    context "end_dateが空の場合" do
      it "end_date無効であること" do
        reservation.end_date = nil
        expect(reservation).to_not be_valid
      end
    end

    context "end_dateがstart_dateよりも過去の場合" do
      it "end_dateが無効であること" do
        reservation.start_date = today.next_day(2)
        reservation.end_date = today.next_day(1)
        expect(reservation).to_not be_valid
      end
    end

    context "start_dateとend_dateが同日の場合" do
      it "データが無効であること" do
        reservation.start_date = today.next_day(1)
        reservation.end_date = today.next_day(1)
        expect(reservation).to_not be_valid
      end
    end

    context "sum_peopleが空の場合" do
      it "sum_peopleが無効であること" do
        reservation.sum_people = nil
        expect(reservation).to_not be_valid
      end
    end

    context "sum_peopleの値が0の場合" do
      it "sum_peopleが無効であること" do
        reservation.sum_people = 0
        expect(reservation).to_not be_valid
      end
    end

    context "sum_peopleの値が負の数の場合" do
      it "sum_peopleが無効であること" do
        reservation.sum_people = -1
        expect(reservation).to_not be_valid
      end
    end

    context "user_idが空の場合" do
      it "データが無効であること" do
        reservation.user_id = nil
        expect(reservation).to_not be_valid
      end
    end

    context "room_idが空の場合" do
      it "データが無効であること" do
        reservation.room_id = nil
        expect(reservation).to_not be_valid
      end
    end
  end
end
