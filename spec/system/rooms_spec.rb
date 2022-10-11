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

  describe "ルームの検索" do
    context "エリア検索で東京と入力した場合"do
      it "addressの値に東京が含まれるルームのみが表示されること" do
        create_list(:room, 30, :main, address: "大阪")
        create_list(:room, 31, :main, address: "東京")
        visit root_path

        all(".form-control")[2].set("東京")

        click_on "探す"

        expect(current_path).to eq search_rooms_path
        expect(page.all(".room-about p")[1]).to have_content "東京"
        expect(page).to have_content "東京", count: 30

        click_link "2"

        expect(current_path).to eq search_rooms_path
        expect(page.all(".room-about p")[1]).to have_content "東京"
        expect(page).to have_content "東京", count: 1
        expect(page).to_not have_content "大阪"
      end
    end
  end

  describe "scopeによる並び順" do
    it "作成日が新しいものから先頭に並ぶこと" do
      create(:room, :main, room_name: "最初", created_at: 1.years.ago)
      create_list(:room, 30, :main, created_at: 1.months.ago)
      create(:room, :main, room_name: "最後", created_at: 1.days.ago)

      visit rooms_path

      expect(page).to have_content "最後"
      expect(page).to_not have_content "最初"
    end
  end
end
