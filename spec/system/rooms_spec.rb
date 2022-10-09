require 'rails_helper'

RSpec.describe "Rooms", type: :system do
  let!(:room) { build(:room, :main)}
  let!(:user) { User.first }
  let!(:rooms) { Room.all }
  before do
    user_login
  end

  describe "ルームの新規登録" do
    context "無効な値を送信した場合" do
      it "登録に失敗すること" do
        expect(rooms.count).to eq 0
        visit new_room_path

        fill_in "ルーム名", with: "hoge"
        fill_in "料金", with: -100

        click_on "登録"

        room.id = 1
        expect(current_path).to_not eq room_path(room)
        within ".error-container" do
          expect(page).to have_content "エラー："
        end
        expect(page).to have_field with: "hoge"
        expect(rooms.count).to_not eq 1
      end
    end

    context "有効な値を送信した場合" do
      it "ルームの登録に成功すること" do
        expect(rooms.count).to eq 0
        visit new_room_path

        fill_in "ルーム名", with: room.room_name
        fill_in "ルーム紹介", with: room.introduction
        fill_in "料金", with: room.price
        fill_in "住所", with: room.address
        attach_file "ルーム画像", "#{Rails.root}/spec/factories/images/test_dummy.jpg"

        click_on "登録"

        room = Room.find_by(room_name: "main room")
        expect(rooms.count).to eq 1
        expect(current_path).to eq room_path(room)
        expect(page).to have_content "ルーム情報を登録しました"
        expect(page).to have_button "予約する"
      end
    end
  end
end
