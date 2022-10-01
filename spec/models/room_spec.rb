require 'rails_helper'

RSpec.describe Room, type: :model do
  describe "valid" do
    let!(:room) { build(:room) }

    context "全ての値が正常な場合" do
      it "データが有効であること" do
        expect(room).to be_valid
      end
    end

    context "room_nameが空の場合" do
      it "room_nameが無効であること" do
        room.room_name = " "
        expect(room).to_not be_valid
      end
    end

    context "room_nameが51文字以上の場合" do
      it "room_nameが無効であること" do
        room.room_name = "a" * 51
        expect(room).to_not be_valid
      end
    end

    context "room_nameが50文字以下の場合" do
      it "room_nameが有効であること" do
        room.room_name = "a" * 50
        expect(room).to be_valid
      end
    end

    context "introductionが空の場合" do
      it "introductionが無効であること" do
        room.introduction = " "
        expect(room).to_not be_valid
      end
    end

    context "priceが空の場合" do
      it "priceが無効であること" do
        room.price = nil
        expect(room).to_not be_valid
      end
    end

    context "priceが0の場合" do
      it "priceが無効であること" do
        room.price = 0
        expect(room).to_not be_valid
      end
    end

    context "priceが負の数の場合" do
      it "priceが無効であること" do
        room.price = -1
        expect(room).to_not be_valid
      end
    end

    context "addressが空の場合" do
      it "addressが無効であること" do
        room.address = " "
        expect(room).to_not be_valid
      end
    end

    context "user_idが空の場合" do
      it "データが無効であること" do
        room.user_id = nil
        expect(room).to_not be_valid
      end
    end
  end
end
